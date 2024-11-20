import 'dart:math';

import 'package:FitZee/models/user_level.dart';
import 'package:FitZee/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:FitZee/services/exercise_database_service.dart';
import 'package:FitZee/services/stepcount_database_service.dart';

class UserProgressService {
  final String tableName = 'user_progress';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        stepCount INTEGER NOT NULL,
        exerciseDurationMinutes INTEGER NOT NULL,
        badge INTEGER NOT NULL,
        badgeSource TEXT NOT NULL
      )
    ''');
  }

  (BadgeType, String) calculateBadge(
      int stepCount, int exerciseDurationMinutes) {
    final exerciseHours = exerciseDurationMinutes / 60.0;

    // Check step count criteria
    BadgeType stepBadge = BadgeType.none;
    if (stepCount >= 10000) {
      stepBadge = BadgeType.gold;
    } else if (stepCount >= 7500) {
      stepBadge = BadgeType.silver;
    } else if (stepCount >= 5000) {
      stepBadge = BadgeType.bronze;
    }

    // Check exercise duration criteria
    BadgeType exerciseBadge = BadgeType.none;
    if (exerciseHours >= 2) {
      exerciseBadge = BadgeType.gold;
    } else if (exerciseHours >= 1.5) {
      exerciseBadge = BadgeType.silver;
    } else if (exerciseHours >= 1.0) {
      exerciseBadge = BadgeType.bronze;
    }

    // If both criteria are met, return "both" as source
    if (stepBadge != BadgeType.none && exerciseBadge != BadgeType.none) {
      return (
        BadgeType.values[max(stepBadge.index, exerciseBadge.index)],
        'Steps and Exercise'
      );
    }
    // Otherwise return the higher badge with its respective source
    else if (exerciseBadge.index > stepBadge.index) {
      return (exerciseBadge, 'exercise');
    } else if (stepBadge.index > exerciseBadge.index) {
      return (stepBadge, 'steps');
    } else {
      return (
        stepBadge,
        stepBadge == BadgeType.none ? 'No Bagde Earned' : 'steps'
      );
    }
  }

  // Method to calculate the total badge counts
  Future<Map<BadgeType, int>> getBadgeTotals() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    // Initialize counters
    int bronzeCount = 0;
    int silverCount = 0;
    int goldCount = 0;

    for (var entry in maps) {
      BadgeType badge = BadgeType.values[entry['badge']];
      if (badge == BadgeType.bronze) {
        bronzeCount++;
      } else if (badge == BadgeType.silver) {
        silverCount++;
      } else if (badge == BadgeType.gold) {
        goldCount++;
      }
    }

    return {
      BadgeType.bronze: bronzeCount,
      BadgeType.silver: silverCount,
      BadgeType.gold: goldCount,
    };
  }

  // New method: Generate badges for the last 20 days
  Future<void> generateLast10DaysBadges() async {
    final db = await DatabaseHelper.instance.database;
    final stepService = StepcountDatabaseService();
    final exerciseService = ExerciseDBService();

    DateTime today = DateTime.now();
    for (int i = 0; i < 20; i++) {
      DateTime targetDate = today.subtract(Duration(days: i));
      String formattedDate =
          "${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}";

      // Fetch step count for the date
      int stepCount = await stepService.getStepsForDate(formattedDate);

      // Fetch total exercise duration for the date
      int exerciseDuration =
          await exerciseService.getTotalExerciseDuration(formattedDate);

      // Calculate badge based on step count and exercise duration
      final (badge, source) = calculateBadge(stepCount, exerciseDuration);

      // Prepare the data for user progress
      final Map<String, dynamic> data = {
        'date': formattedDate,
        'stepCount': stepCount,
        'exerciseDurationMinutes': exerciseDuration,
        'badge': badge.index,
        'badgeSource': source,
      };

      // Check if entry exists for the date and update or insert accordingly
      final List<Map<String, dynamic>> existingRecord = await db.query(
        tableName,
        where: 'date = ?',
        whereArgs: [formattedDate],
      );

      if (existingRecord.isEmpty) {
        await db.insert(tableName, data);
      } else {
        await db.update(
          tableName,
          data,
          where: 'date = ?',
          whereArgs: [formattedDate],
        );
      }
    }
  }

  // Update or insert user progress for a specific date
  Future<void> updateUserProgress(
      String date, int stepCount, int exerciseDurationMinutes) async {
    final database = await DatabaseHelper.instance.database;
    final (badge, source) = calculateBadge(stepCount, exerciseDurationMinutes);

    final Map<String, dynamic> data = {
      'date': date,
      'stepCount': stepCount,
      'exerciseDurationMinutes': exerciseDurationMinutes,
      'badge': badge.index,
      'badgeSource': source,
    };

    // Check if entry exists for the date
    final List<Map<String, dynamic>> existing = await database.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );

    if (existing.isEmpty) {
      await database.insert(tableName, data);
    } else {
      await database.update(
        tableName,
        data,
        where: 'date = ?',
        whereArgs: [date],
      );
    }
  }

  Future<List<UserProgress>> getLeaderboardData() async {
    final db = await DatabaseHelper.instance.database;

    // Query to get all records sorted by badge and step count
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) => UserProgress.fromMap(maps[i]));
  }

  // Fetch step count from StepCount table for a specific date
  Future<int> _getStepCountForDate(String date) async {
    final database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await database.query(
      'StepCount',
      where: 'date = ?',
      whereArgs: [date],
    );
    return result.isEmpty ? 0 : result.first['stepCount'] as int;
  }

  // Implementation of updateProgressFromExercises
  Future<void> updateProgressFromExercises(String date) async {
    final exerciseDb = ExerciseDBService();
    final int exerciseDuration =
        await exerciseDb.getTotalExerciseDuration(date);
    final int stepCount = await _getStepCountForDate(date);

    await updateUserProgress(date, stepCount, exerciseDuration);
  }

  // Get user progress for a specific date
  Future<UserProgress?> getUserProgress(String date) async {
    final database = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
    );

    if (maps.isEmpty) return null;
    return UserProgress.fromMap(maps.first);
  }

  // Calculate points based on Badges Received
  Future<int> calculateTotalPoints() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    int totalPoints = 0;

    for (var entry in maps) {
      BadgeType badge = BadgeType.values[entry['badge']];
      if (badge == BadgeType.bronze) {
        totalPoints += 1;
      } else if (badge == BadgeType.silver) {
        totalPoints += 2;
      } else if (badge == BadgeType.gold) {
        totalPoints += 3;
      }
    }

    print(
        "\n\n############\n\n\nFunction Calc Points: $totalPoints\n\n\n#########\n\n\n");

    return totalPoints;
  }

  // Get all badges for a date range
  // Future<List<UserProgress>> getBadgesForDateRange(
  //     String startDate, String endDate) async {
  //   final database = await DatabaseHelper.instance.database;
  //   final List<Map<String, dynamic>> maps = await database.query(
  //     tableName,
  //     where: 'date BETWEEN ? AND ?',
  //     whereArgs: [startDate, endDate],
  //     orderBy: 'date DESC',
  //   );

  //   return List.generate(maps.length, (i) => UserProgress.fromMap(maps[i]));
  // }

  // Future<List<UserProgress>> getLeaderboardDataWithAggregatedExercise() async {
  //   final db = await DatabaseHelper.instance.database;

  //   final List<Map<String, dynamic>> results = await db.rawQuery('''
  //     SELECT date,
  //            SUM(stepCount) as stepCount,
  //            SUM(exerciseDurationMinutes) as exerciseDurationMinutes,
  //            MAX(badge) as badge,
  //            badgeSource
  //     FROM user_progress
  //     GROUP BY date
  //     ORDER BY stepCount DESC, exerciseDurationMinutes DESC
  //   ''');

  //   return results.map((e) => UserProgress.fromMap(e)).toList();
  // }

  // Get badge statistics
  // Future<Map<String, int>> getBadgeStats(
  //     String startDate, String endDate) async {
  //   final progress = await getBadgesForDateRange(startDate, endDate);

  //   return {
  //     'total': progress.length,
  //     'bronze': progress.where((p) => p.badge == BadgeType.bronze).length,
  //     'silver': progress.where((p) => p.badge == BadgeType.silver).length,
  //     'gold': progress.where((p) => p.badge == BadgeType.gold).length,
  //     'fromSteps': progress.where((p) => p.badgeSource == 'steps').length,
  //     'fromExercise': progress.where((p) => p.badgeSource == 'exercise').length,
  //     'fromBoth': progress.where((p) => p.badgeSource == 'both').length,
  //   };
  // }
}
