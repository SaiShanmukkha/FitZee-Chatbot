import 'package:FitZee/models/step_data.dart';
import 'package:FitZee/utils/database_helper.dart';
import 'package:pedometer_2/pedometer_2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:FitZee/services/user_progress_service.dart';

class StepcountDatabaseService {
  final String tableName = 'StepCount';

  // Method to create the table
  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stepCount INTEGER,
        date TEXT
      )""",
    );
  }

  // Method to get the step count for a specific date
  Future<int> getStepsForDate(String formattedDate) async {
    final db = await DatabaseHelper.instance.database;

    // Query to get step count for the given date
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [formattedDate],
    );

    // Return step count if found, otherwise return 0
    return result.isNotEmpty ? result.first['stepCount'] as int : 0;
  }

  // Helper method to update UserProgress
  Future<void> _updateUserProgress(String date) async {
    final userProgressService = UserProgressService();
    final db = await DatabaseHelper.instance.database;

    // Get the total steps for the date
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );
    final int stepCount = result.isEmpty ? 0 : result.first['stepCount'] as int;

    // Get current progress to preserve exercise duration
    final currentProgress = await userProgressService.getUserProgress(date);
    final exerciseDuration = currentProgress?.exerciseDurationMinutes ?? 0;

    // Update user progress with new step count and existing exercise duration
    await userProgressService.updateUserProgress(
        date, stepCount, exerciseDuration);
  }

  // Insert or update step data into the database
  Future<void> insertStepData(StepCountEntry entry) async {
    final db = await DatabaseHelper.instance.database;

    // Check if a record exists for the given date
    final existingRecord = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [entry.date],
    );

    if (existingRecord.isNotEmpty) {
      // If the record exists, update it by adding the new step count to the existing one
      int existingStepCount = existingRecord.first['stepCount'] as int;
      int updatedStepCount = existingStepCount + entry.stepCount;

      // Update the record with the new step count
      await db.update(
        tableName,
        {'stepCount': updatedStepCount},
        where: 'id = ?',
        whereArgs: [existingRecord.first['id']],
      );
    } else {
      // If no record exists, insert a new one
      await db.insert(
        tableName,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Update user progress after modifying step count
    await _updateUserProgress(entry.date);
  }

  // Insert or update step data into the database with direct value
  Future<void> insertOrUpdateStepData(StepCountEntry entry) async {
    final db = await DatabaseHelper.instance.database;

    // Check if a record exists for the given date
    final existingRecord = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [entry.date],
    );

    if (existingRecord.isNotEmpty) {
      // Update the record with the new step count
      await db.update(
        tableName,
        {'stepCount': entry.stepCount},
        where: 'id = ?',
        whereArgs: [existingRecord.first['id']],
      );
    } else {
      // If no record exists, insert a new one
      await db.insert(
        tableName,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Update user progress after modifying step count
    await _updateUserProgress(entry.date);
  }

  // Method to get total step count for a given month and year
  Future<int> getTotalStepsForMonth(String monthYear) async {
    final db = await DatabaseHelper.instance.database;

    // Query to get all records for the specified month and year
    List<Map<String, dynamic>> records = await db.query(
      tableName,
      where: "strftime('%Y-%m', date) = ?",
      whereArgs: [monthYear],
    );

    // Calculate the total step count
    int totalSteps = records.fold(0, (sum, record) {
      return sum + (record['stepCount'] as int);
    });

    return totalSteps;
  }

  // Method to get all step data from the database
  Future<List<StepCountEntry>> getAllStepData() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: 'date DESC');

    return List.generate(maps.length, (i) {
      return StepCountEntry.fromMap(maps[i]);
    });
  }

  // Method to fetch day-wise step data, grouped by date
  Future<List<Map<String, dynamic>>> getDayWiseStepData() async {
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT 
        date,
        SUM(stepCount) as totalSteps
      FROM 
        $tableName
      GROUP BY 
        date
      ORDER BY 
        date DESC
    ''');

    return results;
  }

  // Method to update step data for the last 7 days
  Future<void> updateLastWeekStepData() async {
    final Pedometer pedometer = Pedometer();

    // Set today as the start of the day (00:00:00)
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);

    for (int i = 0; i < 10; i++) {
      DateTime dateFrom = today.subtract(Duration(days: i));
      DateTime dateTo =
          dateFrom.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));

      try {
        // Fetch the step count for the given date range
        int stepCount =
            await pedometer.getStepCount(from: dateFrom, to: dateTo);

        // Format the date as a string (e.g., "YYYY-MM-DD")
        String formattedDate =
            "${dateTo.year}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}";

        // Create a new StepCountEntry
        StepCountEntry entry =
            StepCountEntry(stepCount: stepCount, date: formattedDate);

        // Insert or update the step data in the database
        await insertOrUpdateStepData(entry);
        // Note: No need to call _updateUserProgress here as it's already called in insertOrUpdateStepData
      } catch (e) {
        print("Error fetching step count for $dateTo: $e");
      }
    }
  }
}
