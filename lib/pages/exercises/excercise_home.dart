import 'package:flutter/material.dart';

class ExercisesHomePage extends StatelessWidget {
  final List<Map<String, String>> availableExercises = [
    {
      'name': 'Push-Up',
      'asset': 'assets/images/pushups.gif',
      'route': '/exercises/pushups'
    },
    {
      'name': 'Squat',
      'asset': 'assets/images/squats.gif',
      'route': '/exercises/squats'
    },
    {
      'name': 'Lunges',
      'asset': 'assets/images/lunges.gif',
      'route': '/exercises/lunges'
    },
    {
      'name': 'Plank',
      'asset': 'assets/images/planks.gif',
      'route': '/exercises/plank'
    },
    {
      'name': 'Burpees',
      'asset': 'assets/images/burpees.gif',
      'route': '/exercises/burpees'
    },
    {
      'name': 'Jumping Jacks',
      'asset': 'assets/images/jumping_jacks.gif',
      'route': '/exercises/jumping_jacks'
    },
    {
      'name': 'Mountain Climbers',
      'asset': 'assets/images/mountain_climbers.gif',
      'route': '/exercises/mountain_climbers'
    },
    {
      'name': 'Deadlift',
      'asset': 'assets/images/deadlift.gif',
      'route': '/exercises/deadlift'
    },
    {
      'name': 'Bicep Curls',
      'asset': 'assets/images/bicep_curls.gif',
      'route': '/exercises/bicep_curls'
    },
    {
      'name': 'Tricep Dips',
      'asset': 'assets/images/triceps.gif',
      'route': '/exercises/triceps'
    },
    {
      'name': 'Chest Press',
      'asset': 'assets/images/chest_press.gif',
      'route': '/exercises/chest_press'
    },
    {
      'name': 'Leg Raises',
      'asset': 'assets/images/leg_raises.gif',
      'route': '/exercises/leg_raises'
    },
    {
      'name': 'Russian Twists',
      'asset': 'assets/images/russian_twists.gif',
      'route': '/exercises/russian_twists'
    },
    {
      'name': 'Shoulder Press',
      'asset': 'assets/images/shoulder_press.gif',
      'route': '/exercises/shoulder_press'
    },
    {
      'name': 'High Knees',
      'asset': 'assets/images/high_knees.gif',
      'route': '/exercises/high_knees'
    },
    {
      'name': 'Jump Rope',
      'asset': 'assets/images/jump_rope.gif',
      'route': '/exercises/jump_rope'
    },
  ];

  // Categories for exercise grouping
  final Map<String, List<String>> categories = {
    'Gain Muscle': [
      'Push-Up',
      'Squat',
      'Deadlift',
      'Bicep Curls',
      'Tricep Dips',
      'Chest Press'
    ],
    'Boost Endurance': [
      'Jumping Jacks',
      'Mountain Climbers',
      'High Knees',
      'Burpees',
      'Jump Rope'
    ],
    'Build Strength': ['Plank', 'Lunges', 'Shoulder Press', 'Leg Raises'],
    'Increase Energy': ['Russian Twists', 'High Knees', 'Jump Rope'],
  };

  // Image assets for categories
  final Map<String, String> categoryImages = {
    'Gain Muscle': 'assets/images/musclegain.png',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start today to become healthy',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 8),
            Text(
              'Choose your fitness goal and start your challenge!',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
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
            ),
          ],
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
