import 'package:flutter/material.dart';

class TricepDipDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tricep Dips: Sculpt Your Arms 💪'),
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
                'assets/images/triceps.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Tricep Dips: The Secret to Defined Arms 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tricep dips are a fantastic bodyweight exercise that primarily targets the triceps, the muscles at the back of your upper arms. This simple yet effective exercise also engages your shoulders, chest, and core, providing a great upper body workout. Tricep dips can be performed using parallel bars, a bench, or even a sturdy chair at home, making them highly accessible and versatile.",
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
                  description: "4-6 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Triceps, Shoulders, Chest",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 10-15 reps",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Difficulty Level",
                  description: "Medium",
                  icon: Icons.flash_on,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Tricep Dips
            Text(
              "How to Perform Tricep Dips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Sit on a bench or chair with your hands gripping the edge, fingers facing forward."),
            BulletPoint(
                text: "Place your feet flat on the ground with your knees bent at 90 degrees."),
            BulletPoint(
                text: "Slowly lower your body toward the ground by bending your elbows to about 90 degrees."),
            BulletPoint(
                text: "Push through your palms to extend your elbows, returning to the starting position."),
            BulletPoint(
                text: "Keep your elbows close to your body throughout the movement, and avoid flaring them out."),

            SizedBox(height: 16),

            // Benefits of Tricep Dips
            Text(
              "Why Tricep Dips Are Essential:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Targeted tricep activation for stronger, more defined arms."),
            BulletPoint(
                text: "Works multiple upper body muscles: triceps, shoulders, and chest."),
            BulletPoint(
                text: "Enhances pushing strength for other lifts and daily tasks."),
            BulletPoint(
                text: "Versatile – can be performed with minimal equipment (just a chair or bench)."),
            BulletPoint(
                text: "Great for improving arm strength and adding definition without isolation exercises."),

            SizedBox(height: 16),

            // Tricep Dip Variations
            Text(
              "Tricep Dip Variations to Challenge Yourself:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Bench Dips: Perform with your hands on a bench and feet on the floor or elevated."),
            BulletPoint(
                text: "Straight-Leg Dips: Keep your legs straight to increase the challenge."),
            BulletPoint(
                text: "Ring Dips: Use gymnastic rings for a greater range of motion and instability."),
            BulletPoint(
                text: "Weighted Dips: Add weight using a dip belt to make the exercise more challenging."),
            BulletPoint(
                text: "Negative Dips: Lower yourself slowly to build strength, especially for beginners."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Tricep Dip Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Perform the exercise with proper form to avoid shoulder strain."),
            BulletPoint(
                text: "Don't lock your elbows at the top of the movement to prevent joint stress."),
            BulletPoint(
                text: "If you experience shoulder pain, avoid deep dips and reduce range of motion."),
            BulletPoint(
                text: "Use a stable bench or chair to prevent instability and accidents."),
            BulletPoint(
                text: "Warm up before the exercise to prepare your joints and muscles."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Tricep dips are a simple yet incredibly effective exercise for building strength and definition in your arms. With consistent practice, you'll notice improved arm tone, better pushing strength, and increased muscle endurance. Whether you're a beginner or an experienced athlete, tricep dips can help you achieve the arms you've always wanted.",
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
