import 'package:FitZee/constants/exercises_data.dart';
import 'package:flutter/material.dart';
import 'package:FitZee/components/workout_tracker.dart';

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
        title: const Text('Exercises', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start today to become healthy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your fitness goal and start your challenge!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categoryImages.keys.length,
                itemBuilder: (context, index) {
                  String category = categoryImages.keys.elementAt(index);
                  String imageAsset = categoryImages[category]!;

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the exercises for this category
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
                    child: Stack(
                      children: [
                        // Background image with shadow for 3D effect
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              imageAsset,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        // Category name
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16)),
                            ),
                            child: Text(
                              category,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              WorkoutTracker(),
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

  const CategoryExercisePage({
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
        title: Text(category, style: const TextStyle(color: Colors.white)),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
