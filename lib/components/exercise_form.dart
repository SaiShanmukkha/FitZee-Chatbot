import 'package:FitZee/components/duration_input.dart';
import 'package:flutter/material.dart';
import 'package:FitZee/models/exercise_data.dart';
import 'package:FitZee/services/exercise_database_service.dart';

class ExerciseForm extends StatefulWidget {
  final VoidCallback onSave; // Callback to notify parent widget after saving

  ExerciseForm({required this.onSave});

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers and variables
  String? _selectedExercise;
  final _durationController =
      TextEditingController(); // For manual duration input
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _dateController = TextEditingController(); // For date input

  // List of exercises
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

  // Reset the form fields after submission
  void _resetForm() {
    setState(() {
      _selectedExercise = null;
      _durationController.clear();
      _setsController.clear();
      _repsController.clear();
      _dateController.clear();
    });
  }

  // Save the exercise to the database
  Future<void> _saveExercise() async {
    if (_formKey.currentState!.validate()) {
      // Parse duration into minutes
      final durationParts = _durationController.text.split(':');
      final durationInMinutes =
          int.parse(durationParts[0]) * 60 + int.parse(durationParts[1]);

      final newExercise = ExerciseEntry(
        name: _selectedExercise!,
        duration: durationInMinutes,
        sets: int.parse(_setsController.text),
        reps: int.parse(_repsController.text),
        date: _dateController.text,
      );

      await ExerciseDBService().insertExercise(newExercise);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exercise saved successfully!')),
      );

      _resetForm();
      widget.onSave(); // Notify parent widget after saving
    }
  }

  // Pick a date
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 3), // Shadow position (horizontal, vertical)
          ),
        ],
        border: Border.all(
          color: Colors.deepPurple, // Optional border color
          width: 1.0, // Border width
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Your Workout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedExercise,
              decoration: InputDecoration(labelText: 'Exercise Name'),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an exercise';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            DurationInput(controller: _durationController),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _setsController,
                    decoration: InputDecoration(labelText: 'Sets'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sets';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _repsController,
                    decoration: InputDecoration(labelText: 'Reps'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter reps';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: 'YYYY-MM-DD',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveExercise,
              child: Text('Save Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
