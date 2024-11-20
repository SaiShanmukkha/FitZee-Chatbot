import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAIService {
  static const String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey = dotenv.env['FZ_OPENAI_KEY'] ?? '';

  Future<String> fetchReply(
      String question, List<Map<String, dynamic>> chatHistory) async {
    if (apiKey.isEmpty) {
      return "OpenAI API key not found. Please check your .env file.";
    }

    try {
      // Send POST request to OpenAI API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are diet & exercise recommendor. You will 'Sorry, I cant help you with that.' response for all unrelated to health & diet. You dont give code or programming or any other just only health, diet, foods,etc. For 'Hi', 'Hello', messages, you can say i am fitzeebot here to help you with health & diet. you can customize that message. Make sure to give output in pure plain text."
            },
            ...chatHistory,
            {"role": "user", "content": question}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        print("OpenAI API error: ${response.body}");
        return "Error generating a response.";
      }
    } catch (e) {
      print("Error in OpenAIService: $e");
      return "Error generating a response.";
    }
  }
}
