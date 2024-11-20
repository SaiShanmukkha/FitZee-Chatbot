import 'package:FitZee/services/chat_database_service.dart';
import 'package:FitZee/services/exercise_database_service.dart';
import 'package:FitZee/services/stepcount_database_service.dart';
import 'package:FitZee/services/user_progress_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // await deleteDatabaseFile();
    _database = await _initDatabase();
    await checkTables(); // Check tables after initialization for verification
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'FitZee_steps.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onOpen: (db) {
        print("Database opened at $path");
      },
    );
  }

  Future<void> _createDatabase(Database database, int version) async {
    print("Creating tables...");
    await StepcountDatabaseService().createTable(database);
    await ExerciseDBService().createTable(database);
    await UserProgressService().createTable(database);
    await ChatDatabaseService().createTable(database);
  }

  // Delete database for testing purposes
  // Future<void> deleteDatabaseFile() async {
  //   String path = join(await getDatabasesPath(), 'FitZee_steps.db');
  //   await deleteDatabase(path);
  //   print("Database deleted.");
  // }

  // Check tables in the database
  Future<void> checkTables() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print("Tables in database: $tables");
  }
}
