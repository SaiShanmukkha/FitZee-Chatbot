import 'package:flutter/material.dart';

class MountainClimbersDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mountain Climbers: Climb Your Way to Fitness 🏔️'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/mountain_climbers.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Mountain Climbers: The Ultimate Full-Body Workout! 🏃‍♂️💨",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Mountain Climbers are an intense, high-intensity cardio exercise that engages multiple muscle groups, boosts your metabolism, and improves endurance. They mimic the movement of climbing a mountain, providing a dynamic and fun way to stay fit.",
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
                  description: "Core, Legs, Shoulders",
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
                  description: "High",
                  icon: Icons.flash_on,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Mountain Climbers
            Text(
              "How to Perform Mountain Climbers:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Start in a plank position with your hands under your shoulders."),
            BulletPoint(
                text: "Keep your body straight from head to heels and engage your core."),
            BulletPoint(
                text: "Drive your right knee toward your chest, then quickly return it to the plank position."),
            BulletPoint(
                text: "Simultaneously, drive your left knee toward your chest while returning your right leg."),
            BulletPoint(
                text: "Repeat the movement at a fast pace, alternating legs quickly."),

            SizedBox(height: 16),

            // Benefits of Mountain Climbers
            Text(
              "Why Mountain Climbers Are Amazing:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Great full-body exercise that works your arms, core, legs, and shoulders."),
            BulletPoint(
                text: "Boosts cardiovascular endurance and helps burn calories quickly."),
            BulletPoint(
                text: "Improves agility, coordination, and balance."),
            BulletPoint(
                text: "Increases overall body strength and endurance."),
            BulletPoint(
                text: "Can be performed anywhere, no equipment required!"),

            SizedBox(height: 16),

            // Variations of Mountain Climbers
            Text(
              "Mountain Climber Variations to Challenge Yourself:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Slow Mountain Climbers: Perform the exercise more slowly to focus on core strength."),
            BulletPoint(
                text: "Cross-Body Mountain Climbers: Bring your knee toward the opposite elbow for added core engagement."),
            BulletPoint(
                text: "Plank-to-Push-Up Mountain Climbers: Combine a plank and push-up to increase intensity."),
            BulletPoint(
                text: "Spider Mountain Climbers: Drive your knee toward the outside of your elbow for a greater core challenge."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Safety Tips for Mountain Climbers:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Warm up before starting to prevent injuries and improve flexibility."),
            BulletPoint(
                text: "Focus on maintaining a straight back and engaging your core throughout the exercise."),
            BulletPoint(
                text: "If you experience wrist or shoulder discomfort, try a modified version or consult a professional."),
            BulletPoint(
                text: "Start slow if you're new to mountain climbers, gradually increasing speed as you build strength."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Mountain Climbers are a fantastic addition to any workout routine, offering full-body engagement and an excellent way to boost cardiovascular health. Whether you're looking to increase endurance or burn calories, mountain climbers will get your heart pumping and your muscles working!",
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
