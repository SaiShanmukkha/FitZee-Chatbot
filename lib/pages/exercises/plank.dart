import 'package:flutter/material.dart';

class PlankDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master the Plank! 🪵💪'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/planks.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Plank: The Core Crusher!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "The plank is a core-strengthening exercise that builds endurance and stability in your abdominal muscles, lower back, and shoulders. It may look simple, but holding that position will make you feel the burn!",
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
                  description: "3-5 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Core, Shoulders",
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Ideal Duration",
                  description: "30-60 sec",
                  icon: Icons.timer,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Intensity Level",
                  description: "Moderate",
                  icon: Icons.speed,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform a Plank
            Text(
              "How to Perform a Perfect Plank:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Start by lying face down on the floor, then lift your body onto your forearms and toes."),
            BulletPoint(
                text:
                    "Keep your body in a straight line from head to heels. Don’t let your hips sag or pike up."),
            BulletPoint(
                text:
                    "Engage your core, glutes, and legs to maintain stability."),
            BulletPoint(
                text:
                    "Hold this position, breathing steadily, for as long as you can maintain good form."),

            SizedBox(height: 16),

            // Benefits of Planks
            Text(
              "Why Planks Are Essential:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Strengthen your core, which improves posture and reduces the risk of back pain."),
            BulletPoint(
                text:
                    "Engage multiple muscle groups, including your shoulders, back, and glutes."),
            BulletPoint(
                text:
                    "Enhance your balance and stability, which is crucial for athletic performance."),
            BulletPoint(
                text:
                    "Great for functional fitness, helping you perform everyday tasks with ease."),

            SizedBox(height: 16),

            // Variations of Planks
            Text(
              "Spice Up Your Plank Routine:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Side Plank: Balance on one forearm and the side of one foot to target your obliques."),
            BulletPoint(
                text:
                    "Plank with Leg Lift: Lift one leg off the ground to engage your glutes and challenge your balance."),
            BulletPoint(
                text:
                    "Forearm Plank: Rest on your forearms for a more intense core workout."),
            BulletPoint(
                text:
                    "Plank Jacks: Add a cardio twist by jumping your feet in and out while holding a plank."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Plank Safely and Effectively:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Warm up your core and shoulders before planking to prevent strain."),
            BulletPoint(
                text:
                    "Focus on quality over duration; maintain a strong and stable form."),
            BulletPoint(
                text:
                    "If you feel lower back pain, stop immediately and reassess your form."),
            BulletPoint(
                text:
                    "Modify by placing your knees on the ground if you’re a beginner or need a break."),

            SizedBox(height: 16),
            // Conclusion
            Text(
              "Planks may be tough, but they’re worth it! Incorporate them into your routine for a stronger, more stable core. With consistency, you’ll plank like a pro in no time!",
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

  InfoBox(
      {required this.title,
      required this.description,
      required this.icon,
      required this.color});

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
