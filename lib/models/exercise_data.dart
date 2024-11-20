class ExerciseEntry {
  final int? id;
  final String name;
  final int duration;
  final int sets;
  final int reps;
  final String date;

  ExerciseEntry({
    this.id,
    required this.name,
    required this.duration,
    required this.sets,
    required this.reps,
    required this.date,
  });

  // Convert from Map to ExerciseEntry
  factory ExerciseEntry.fromMap(Map<String, dynamic> map) {
    return ExerciseEntry(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
      sets: map['sets'],
      reps: map['reps'],
      date: map['date'],
    );
  }

  // Convert ExerciseEntry to Map for inserting into the database
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'sets': sets,
      'reps': reps,
      'date': date,
    };
  }
}
