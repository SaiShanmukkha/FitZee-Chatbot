class StepCountEntry {
  final int? id;
  final String date; 
  final int stepCount;

  StepCountEntry({this.id, required this.stepCount, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stepCount': stepCount,
      'date': date, 
    };
  }

  factory StepCountEntry.fromMap(Map<String, dynamic> map) {
    return StepCountEntry(
      id: map['id'],
      stepCount: map['stepCount'],
      date: map['date'],
    );
  }
}
