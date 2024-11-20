import 'package:flutter/material.dart';

class JumpingJacksDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jumping Jacks: Jump into Fitness! 🚀'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/jumping_jacks.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Jumping Jacks: A Fun Cardio Exercise!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Jumping Jacks are a simple yet effective full-body exercise that engages multiple muscle groups and helps improve cardiovascular fitness. Perfect for warming up or as part of your cardio routine!",
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
                  description: "8-12 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Legs, Arms, Core",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Duration",
                  description: "30 sec - 1 min",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Intensity Level",
                  description: "Moderate",
                  icon: Icons.speed,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Jumping Jacks
            Text(
              "How to Perform a Jumping Jack:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Stand with your feet together and arms at your sides."),
            BulletPoint(
                text: "Jump your feet out to the sides while raising your arms overhead."),
            BulletPoint(
                text: "Land softly with your legs bent and your arms fully extended above your head."),
            BulletPoint(
                text: "Jump back to the starting position, bringing your feet together and arms at your sides."),
            BulletPoint(
                text: "Repeat the movement, keeping a steady pace throughout."),

            SizedBox(height: 16),

            // Benefits of Jumping Jacks
            Text(
              "Why Jumping Jacks Are Great:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Boosts heart health and improves cardiovascular endurance."),
            BulletPoint(
                text: "Engages multiple muscle groups, including legs, arms, and core."),
            BulletPoint(
                text: "Increases overall body coordination and agility."),
            BulletPoint(
                text: "Can be done anywhere, without any special equipment."),
            BulletPoint(
                text: "Great for warming up or as part of a high-intensity interval training (HIIT) routine."),

            SizedBox(height: 16),

            // Variations of Jumping Jacks
            Text(
              "Jumping Jack Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Step-Out Jumping Jacks: Instead of jumping, step one foot out at a time for a low-impact version."),
            BulletPoint(
                text: "Speed Jacks: Perform the jumping jacks at a faster pace for an intense cardio session."),
            BulletPoint(
                text: "Squat Jacks: Begin each jumping jack with a squat before jumping, adding a strength component."),
            BulletPoint(
                text: "Plank Jacks: From a plank position, jump your feet out and in for an added core challenge."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Safety Tips for Jumping Jacks:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Warm up before jumping jacks to avoid injury and prepare your muscles."),
            BulletPoint(
                text: "Focus on soft landings to reduce impact on your knees and joints."),
            BulletPoint(
                text: "Perform at a controlled pace to maintain proper form and avoid overexertion."),
            BulletPoint(
                text: "Take breaks if needed, especially during long sets of jumping jacks."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Jumping Jacks are a simple yet effective exercise that can significantly improve your fitness level. Whether you're looking to boost your cardio, engage your muscles, or warm up for a workout, jumping jacks are a great addition to any routine!",
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
