// Enhanced ExerciseDBService with total duration calculations
import 'package:FitZee/models/exercise_data.dart';
import 'package:FitZee/services/user_progress_service.dart';
import 'package:FitZee/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseDBService {
  final String tableName = "exercise";

  // Method to create the table
  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        duration INTEGER,
        sets INTEGER,
        reps INTEGER,
        date TEXT
      )""",
    );
  }

  // Insert exercise data
  Future<void> insertExercise(ExerciseEntry exercise) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      tableName,
      exercise.toMap(),
    );

    // Update user progress after inserting exercise
    final userProgressDb = UserProgressService();
    await userProgressDb.updateProgressFromExercises(exercise.date);
  }

  // Fetch all exercises
  Future<List<ExerciseEntry>> fetchAllExercises() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => ExerciseEntry.fromMap(map)).toList();
  }

  // Fetch exercises by date
  // Future<List<ExerciseEntry>> fetchExercisesByDate(String date) async {
  //   final db = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     tableName,
  //     where: 'date = ?',
  //     whereArgs: [date],
  //   );
  //   return maps.map((map) => ExerciseEntry.fromMap(map)).toList();
  // }

  // Calculate total exercise duration for a specific date
  Future<int> getTotalExerciseDuration(String date) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('''
      SELECT SUM(duration) as totalDuration 
      FROM $tableName 
      WHERE date = ?
    ''', [date]);

    return result.first['totalDuration'] as int? ?? 0;
  }

  // Get exercise summary for a date range
  // Future<Map<String, dynamic>> getExerciseSummary(
  //     String startDate, String endDate) async {
  //   final db = await DatabaseHelper.instance.database;
  //   final result = await db.rawQuery('''
  //     SELECT
  //       COUNT(*) as totalExercises,
  //       SUM(duration * sets) as totalDuration,
  //       COUNT(DISTINCT date) as totalDays,
  //       AVG(duration * sets) as avgDurationPerDay
  //     FROM $tableName
  //     WHERE date BETWEEN ? AND ?
  //   ''', [startDate, endDate]);

  //   return result.first;
  // }

  // Update exercise entry
  // Future<void> updateExercise(int id, ExerciseEntry updatedExercise) async {
  //   final db = await DatabaseHelper.instance.database;
  //   await db.update(
  //     tableName,
  //     updatedExercise.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   // Update user progress after updating exercise
  //   final userProgressDb = UserProgressService();
  //   await userProgressDb.updateProgressFromExercises(updatedExercise.date);
  // }

  // Delete exercise entry
  Future<void> deleteExercise(int id) async {
    final db = await DatabaseHelper.instance.database;
    final exercise = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (exercise.isNotEmpty) {
      final date = exercise.first['date'] as String;
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      final userProgressDb = UserProgressService();
      await userProgressDb.updateProgressFromExercises(date);
    }
  }
}
