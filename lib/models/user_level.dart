// Enum for badge types
enum BadgeType {
  none,
  bronze,
  silver,
  gold
}

// Model for UserProgress
class UserProgress {
  final int? id;
  final String date;
  final int stepCount;
  final int exerciseDurationMinutes;
  final BadgeType badge;
  final String badgeSource;

  UserProgress({
    this.id,
    required this.date,
    required this.stepCount,
    required this.exerciseDurationMinutes,
    required this.badge,
    required this.badgeSource,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'stepCount': stepCount,
      'exerciseDurationMinutes': exerciseDurationMinutes,
      'badge': badge.index,
      'badgeSource': badgeSource,
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      id: map['id'],
      date: map['date'],
      stepCount: map['stepCount'],
      exerciseDurationMinutes: map['exerciseDurationMinutes'],
      badge: BadgeType.values[map['badge']],
      badgeSource: map['badgeSource'],
    );
  }
}