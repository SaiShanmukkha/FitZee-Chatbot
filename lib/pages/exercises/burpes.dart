import 'package:flutter/material.dart';

class BurpeesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burpees: Full-Body Blast! 💥'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/burpees.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Burpees: A Full-Body Powerhouse!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Burpees are one of the best total-body exercises you can perform. This high-intensity move builds strength, improves endurance, and gets your heart pumping for a serious calorie burn!",
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
                  description: "10-15 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Chest, Legs, Core",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Duration",
                  description: "20-30 sec",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Intensity Level",
                  description: "High",
                  icon: Icons.speed,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Burpees
            Text(
              "How to Perform a Burpee:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Start by standing with your feet shoulder-width apart and arms at your sides."),
            BulletPoint(
                text:
                    "Squat down and place your hands on the floor in front of you."),
            BulletPoint(
                text:
                    "Jump your feet back into a plank position while keeping your body in a straight line."),
            BulletPoint(
                text:
                    "Perform a push-up (optional) to engage your chest and triceps."),
            BulletPoint(
                text:
                    "Jump your feet forward, returning to the squat position."),
            BulletPoint(
                text:
                    "Explode upward, jumping as high as you can while reaching your arms overhead."),
            BulletPoint(
                text:
                    "Land softly, immediately going into the next rep."),

            SizedBox(height: 16),

            // Benefits of Burpees
            Text(
              "Why Burpees Are Amazing:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Boost cardiovascular fitness with high-intensity intervals."),
            BulletPoint(
                text:
                    "Build total-body strength by engaging multiple muscle groups."),
            BulletPoint(
                text:
                    "Increase power and agility, great for athletic performance."),
            BulletPoint(
                text:
                    "Improve muscular endurance, helping you handle prolonged physical activity."),

            SizedBox(height: 16),

            // Variations of Burpees
            Text(
              "Burpee Variations to Level Up:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Half Burpee: Perform the jump and squat, but skip the push-up for a lower-impact version."),
            BulletPoint(
                text:
                    "Burpee with Tuck Jump: After the jump, tuck your knees to your chest for an added challenge."),
            BulletPoint(
                text:
                    "Mountain Climber Burpee: Add mountain climbers between the push-up and jump for a core challenge."),
            BulletPoint(
                text:
                    "Box Jump Burpee: After the jump, immediately jump onto a box or elevated surface for more intensity."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Safety Tips for Burpees:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Warm up properly to prepare your joints and muscles for this explosive movement."),
            BulletPoint(
                text:
                    "Start with lower-intensity variations if you're new to burpees."),
            BulletPoint(
                text:
                    "Maintain good form to prevent injury: avoid slouching during the push-up and ensure your landings are soft."),
            BulletPoint(
                text:
                    "Take breaks as needed; burpees are intense, so listen to your body."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Burpees are tough, but they get results! Incorporate them into your routine for improved strength, endurance, and calorie burn. The more you practice, the easier they’ll get, so push through the burn!",
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
