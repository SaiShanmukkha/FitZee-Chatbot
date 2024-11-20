import 'package:FitZee/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:FitZee/services/chat_database_service.dart';
import 'package:FitZee/services/openai_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _inputController = TextEditingController();
  int currentMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadMessages([int offset = 0, int limit = 50]) async {
    setState(() => isLoading = true);
    final db = await DatabaseHelper.instance.database;
    final fetchedMessages =
        await ChatDatabaseService().fetchMessages(db, offset, limit);

    setState(() {
      messages.addAll(fetchedMessages); // Append fetched messages
      currentMessageCount = messages.length;
      isLoading = false;
    });

    // Scroll to the bottom if this is the initial load
    if (_scrollController.hasClients && offset == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.minScrollExtent &&
        !isLoading) {
      _loadMessages(currentMessageCount);
    }
  }

  Future<void> _sendMessage(String userInput) async {
    final db = await DatabaseHelper.instance.database;
    final timestamp = DateTime.now().toIso8601String();

    print("\n\n\n#########\n\n\nUser Input:$userInput\n\n\n########\n\n\n");

    // Add user message to the chat
    setState(() {
      messages.add({
        'userInput': userInput,
        'botReply': null,
        'timestamp': timestamp,
      });
    });

    // Prepare chat history excluding the last message
    final chatHistory = messages
        .sublist(0, messages.length - 1) // Exclude the last message
        .expand((msg) => [
              if (msg['userInput'] != null)
                {"role": "user", "content": msg['userInput']},
              if (msg['botReply'] != null)
                {"role": "assistant", "content": msg['botReply']},
            ])
        .toList();

    try {
      // Get bot reply
      final response = await OpenAIService().fetchReply(userInput, chatHistory);
      print("\n\n\n######\n\n\nResponse:$response\n\n\n#######\n\n\n");
      // Update the last message with the bot's reply
      setState(() {
        messages.last['botReply'] = response;
      });

      // Save the message to the database
      db.insert('chat', messages.last);
    } catch (e) {
      setState(() {
        messages.last['botReply'] = 'Error: Retry by clicking reload.';
      });
    }
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    // Extract message content safely
    final userInput = message['userInput'] ?? '';
    final botReply = message['botReply'] ?? '';
    final timestamp = message['timestamp'] ?? 'Unknown time';

    return Column(
      crossAxisAlignment:
          botReply.isEmpty ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Display timestamp
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            timestamp,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ),

        // User message
        if (userInput.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 16.0, left: 64.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 10, 59),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      userInput,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Bot response
        if (botReply.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 64.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      botReply,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Retry button (if no bot reply yet)
        if (botReply.isEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _retryMessage(message),
            ),
          ),
      ],
    );
  }

  void _retryMessage(Map<String, dynamic> message) {
    _sendMessage(message['userInput']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FitZeeBot'),
            Text(
              'Diet and Exercise recommendator',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      counterText: '${_inputController.text.length}/300',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final input = _inputController.text.trim();
                    if (input.isNotEmpty) {
                      _sendMessage(input);
                      _inputController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
