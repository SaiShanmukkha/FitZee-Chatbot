import 'package:FitZee/components/exercise_form.dart';
import 'package:FitZee/services/user_data_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:FitZee/models/exercise_data.dart';
import 'package:FitZee/services/exercise_database_service.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseList> {
  late Future<List<ExerciseEntry>> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = ExerciseDBService().fetchAllExercises();
  }

  // Refresh the exercise list after any updates
  Future<void> _refreshList() async {
    setState(() {
      _exercises = ExerciseDBService().fetchAllExercises();
    });

    await UserDataSyncService().syncPointsToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercise Tracker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExerciseForm(
                onSave:
                    _refreshList, // Refresh the list after saving a new exercise
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Your Exercises",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            FutureBuilder<List<ExerciseEntry>>(
              future: _exercises,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading exercises"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "No exercises logged yet. Start adding some!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  final exercises = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return ExerciseListItem(
                        exercise: exercise,
                        onDelete: () => _deleteExercise(exercise.id!),
                        // onEdit: () => _editExercise(exercise),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Delete an exercise entry
  Future<void> _deleteExercise(int id) async {
    await ExerciseDBService().deleteExercise(id);
    await _refreshList();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Exercise deleted successfully")),
    );
  }

  // Edit exercise (future enhancement for editing functionality)
  // void _editExercise(ExerciseEntry exercise) {
  //   // Navigate to an edit screen or show a modal for editing
  //   // This can be implemented based on your app's design
  //   print("Editing exercise: ${exercise.name}");
  // }
}

class ExerciseListItem extends StatelessWidget {
  final ExerciseEntry exercise;
  final VoidCallback onDelete;
  // final VoidCallback onEdit;

  const ExerciseListItem({
    Key? key,
    required this.exercise,
    required this.onDelete,
    // required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple.shade100,
          child: Text(
            exercise.name.substring(0, 1).toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
        ),
        title: Text(
          exercise.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Duration: ${exercise.duration} mins"),
            Text("Sets: ${exercise.sets}, Reps: ${exercise.reps}"),
            Text("Date: ${exercise.date.split('T')[0]}"),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              // onEdit();
            } else if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => [
            // PopupMenuItem(
            //   value: 'edit',
            //   child: Text('Edit'),
            // ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
