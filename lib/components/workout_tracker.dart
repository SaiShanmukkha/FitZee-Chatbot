import 'dart:async';
import 'package:flutter/material.dart';
import 'package:FitZee/models/exercise_data.dart';
import 'package:FitZee/services/exercise_database_service.dart';

class WorkoutTracker extends StatefulWidget {
  @override
  _WorkoutTrackerState createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker>
    with TickerProviderStateMixin {
  // Stopwatch state
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _formattedTime = "00:00:00";

  // Form field controllers
  String? _selectedExercise;
  int _sets = 1;
  int _reps = 1;

  // Update stopwatch display
  void _updateStopwatch() {
    final duration = _stopwatch.elapsed;
    setState(() {
      _formattedTime =
          "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
    });
  }

  // Start the stopwatch
  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer =
          Timer.periodic(const Duration(seconds: 1), (_) => _updateStopwatch());
    }
  }

  // Pause the stopwatch
  void _pauseStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    }
  }

  // Reset the stopwatch
  void _resetStopwatch() {
    _pauseStopwatch();
    _stopwatch.reset();
    _updateStopwatch();
  }

  // Save data to the database
  Future<void> _saveExercise() async {
    if (_selectedExercise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an exercise.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final minutes = _stopwatch.elapsed.inMinutes; // Only consider total minutes

    if (minutes == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Duration must be at least 1 minute.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newExercise = ExerciseEntry(
      name: _selectedExercise!,
      duration: minutes,
      sets: _sets,
      reps: _reps,
      date: DateTime.now().toIso8601String().split("T")[0],
    );

    final exerciseDBService = ExerciseDBService();
    await exerciseDBService.insertExercise(newExercise);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    _resetFields();
  }

  // Reset fields and stopwatch
  void _resetFields() {
    setState(() {
      _selectedExercise = null;
      _sets = 1;
      _reps = 1;
    });
    _resetStopwatch();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> availableExercises = [
      {'name': 'Push-Up', 'asset': 'assets/images/pushups.gif'},
      {'name': 'Squat', 'asset': 'assets/images/squats.gif'},
      {'name': 'Lunges', 'asset': 'assets/images/lunges.gif'},
      {'name': 'Plank', 'asset': 'assets/images/planks.gif'},
      {'name': 'Burpees', 'asset': 'assets/images/burpees.gif'},
      {'name': 'Jumping Jacks', 'asset': 'assets/images/jumping_jacks.gif'},
      {
        'name': 'Mountain Climbers',
        'asset': 'assets/images/mountain_climbers.gif'
      },
      {'name': 'Deadlift', 'asset': 'assets/images/deadlift.gif'},
      {'name': 'Bicep Curls', 'asset': 'assets/images/bicep_curls.gif'},
      {'name': 'Tricep Dips', 'asset': 'assets/images/triceps.gif'},
      {'name': 'Chest Press', 'asset': 'assets/images/chest_press.gif'},
      {'name': 'Leg Raises', 'asset': 'assets/images/leg_raises.gif'},
      {'name': 'Russian Twists', 'asset': 'assets/images/russian_twists.gif'},
      {'name': 'Shoulder Press', 'asset': 'assets/images/shoulder_press.gif'},
      {'name': 'High Knees', 'asset': 'assets/images/high_knees.gif'},
      {'name': 'Jump Rope', 'asset': 'assets/images/jump_rope.gif'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Track Your Workout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),
          // Animated Timer
          Center(
            child: Text(
              _formattedTime,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Stopwatch Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startStopwatch,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Start'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _pauseStopwatch,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Pause'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Exercise Dropdown
          DropdownButtonFormField<String>(
            value: _selectedExercise,
            decoration: const InputDecoration(labelText: 'Exercise'),
            items: availableExercises
                .map((exercise) => DropdownMenuItem<String>(
                      value: exercise['name'],
                      child: Text(exercise['name']!),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedExercise = value;
              });
            },
          ),
          const SizedBox(height: 16),
          // Sets and Reps
          Row(
            children: [
              Expanded(
                child: _buildCounter(
                  label: 'Sets',
                  value: _sets,
                  onIncrement: () => setState(() => _sets++),
                  onDecrement: () =>
                      setState(() => _sets = _sets > 1 ? _sets - 1 : 1),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCounter(
                  label: 'Reps',
                  value: _reps,
                  onIncrement: () => setState(() => _reps++),
                  onDecrement: () =>
                      setState(() => _reps = _reps > 1 ? _reps - 1 : 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Save Button
          Center(
            child: ElevatedButton(
              onPressed: _saveExercise,
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Save Exercise'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_circle, color: Colors.red),
            ),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
