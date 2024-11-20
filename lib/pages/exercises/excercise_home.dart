import 'package:FitZee/constants/exercises_data.dart';
import 'package:flutter/material.dart';

class ExercisesHomePage extends StatelessWidget {
  // Image assets for categories
  final Map<String, String> categoryImages = {
    'Gain Muscle': 'assets/images/musclegain.gif',
    'Boost Endurance': 'assets/images/endurance.jpg',
    'Build Strength': 'assets/images/buildstrength.png',
    'Increase Energy': 'assets/images/energy.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start today to become healthy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Choose your fitness goal and start your challenge!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap:
                    true, // Allows GridView inside SingleChildScrollView
                physics:
                    NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.keys.length,
                itemBuilder: (context, index) {
                  String category = categories.keys.elementAt(index);
                  String imageAsset = categoryImages[category]!;
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new page that lists exercises for this category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryExercisePage(
                            category: category,
                            exercises: categories[category]!,
                            availableExercises: availableExercises,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(imageAsset),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),// Add ExerciseForm as a component below the grid
            ],
          ),
        ),
      ),
    );
  }
}

// Page to list exercises for a selected category
class CategoryExercisePage extends StatelessWidget {
  final String category;
  final List<String> exercises;
  final List<Map<String, String>> availableExercises;

  CategoryExercisePage({
    required this.category,
    required this.exercises,
    required this.availableExercises,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredExercises = availableExercises
        .where((exercise) => exercises.contains(exercise['name']))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: filteredExercises.length,
          itemBuilder: (context, index) {
            final exercise = filteredExercises[index];
            return ListTile(
              leading: Image.asset(
                exercise['asset']!,
                width: 50,
                height: 50,
              ),
              title: Text(
                exercise['name']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, exercise['route']!);
              },
            );
          },
        ),
      ),
    );
  }
}
