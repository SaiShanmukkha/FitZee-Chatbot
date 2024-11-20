import 'package:sqflite/sqflite.dart';

class ChatDatabaseService {
  // Create table for chat messages
  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS chat(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userInput TEXT NOT NULL,
        botReply TEXT,
        timestamp TEXT NOT NULL
      )
    ''');
    print("\n\n######## Chat table created ########\n\n");
  }

  // Insert a new message
  Future<int> insertMessage(
      Database database, Map<String, dynamic> message) async {
    return await database.insert('chat', message);
  }

  Future<List<Map<String, dynamic>>> fetchMessages(
      Database database, int offset, int limit) async {
    return await database.query(
      'chat',
      orderBy: 'timestamp ASC',
      limit: limit,
      offset: offset,
    );
  }

  // Delete all messages (optional, for testing or reset)
  Future<void> clearMessages(Database database) async {
    await database.delete('chat');
    print("All chat messages cleared.");
  }
}
