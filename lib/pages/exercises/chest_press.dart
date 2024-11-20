import 'package:flutter/material.dart';

class ChestPressDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Press: Build a Strong Chest 💪'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/chest_press.gif', // Make sure the image is correctly added in your assets folder
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Chest Press: The Key to a Strong Chest 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "The chest press is one of the most effective exercises for targeting the chest muscles, specifically the pectoralis major. This exercise can be performed with dumbbells, a barbell, or a machine and is essential for building upper body strength. A strong chest is not only important for strength but also contributes to improved posture and functionality in daily activities.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // 2x2 Info Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                InfoBox(
                  title: "Calories Burned",
                  description: "6-10 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Chest, Shoulders, Triceps",
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 8-12 reps",
                  icon: Icons.timer,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Difficulty Level",
                  description: "Medium to High",
                  icon: Icons.flash_on,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Chest Press
            Text(
              "How to Perform the Chest Press:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Lie flat on your back on a bench with your feet planted on the floor."),
            BulletPoint(text: "Grip the barbell or dumbbells with your palms facing forward, and position them at chest level."),
            BulletPoint(text: "Press the weights upward, extending your arms fully without locking your elbows."),
            BulletPoint(text: "Lower the weights slowly and in a controlled manner until your elbows are at a 90-degree angle."),
            BulletPoint(text: "Make sure your back stays flat against the bench throughout the movement."),

            SizedBox(height: 16),

            // Benefits of Chest Press
            Text(
              "Benefits of Chest Press:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Builds a strong and well-defined chest."),
            BulletPoint(text: "Increases pushing strength for everyday tasks."),
            BulletPoint(text: "Improves upper body muscle mass and strength."),
            BulletPoint(text: "Targets the shoulders and triceps for a full upper-body workout."),
            BulletPoint(text: "Helps improve posture and enhances overall physical performance."),

            SizedBox(height: 16),

            // Chest Press Variations
            Text(
              "Chest Press Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Incline Chest Press: Performed on an incline bench to target the upper chest."),
            BulletPoint(text: "Decline Chest Press: Performed on a decline bench to target the lower chest."),
            BulletPoint(text: "Dumbbell Chest Press: Use dumbbells for a greater range of motion and stability challenge."),
            BulletPoint(text: "Machine Chest Press: Use a machine to focus on isolating the chest with added stability."),
            BulletPoint(text: "Close-Grip Chest Press: Use a closer grip to emphasize triceps and inner chest.") ,

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Chest Press Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Warm-up properly before starting the exercise to prepare your muscles."),
            BulletPoint(text: "Always keep your movements controlled, especially when lowering the weights."),
            BulletPoint(text: "Avoid locking your elbows to protect your joints."),
            BulletPoint(text: "If using heavy weights, consider using a spotter to assist in safety."),
            BulletPoint(text: "Don't overextend the elbows, keep them slightly bent at the top to reduce stress on the joint."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "The chest press is an essential compound exercise for anyone looking to develop strength in the chest, shoulders, and triceps. Whether you're a beginner or advanced lifter, incorporating this movement into your routine will help you build upper body strength and improve your overall physique. Stay consistent and safe, and you'll see progress in no time!",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom InfoBox Widget
class InfoBox extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  InfoBox({required this.title, required this.description, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Custom Bullet Point Widget
class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('•', style: TextStyle(fontSize: 20, height: 1.5)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }
}
