import 'package:flutter/material.dart';

class JumpRopeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jump Rope: The Ultimate Cardio Workout!'),
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
                'assets/images/jump_rope.gif', // Ensure the image is placed in assets/images
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Jump Rope: The Ultimate Cardio Workout! 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Jump rope is a fun and highly effective cardiovascular exercise that engages multiple muscle groups while improving coordination, agility, and endurance. It’s a fantastic way to torch calories and elevate your heart rate, making it perfect for both beginners and seasoned athletes.",
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
                  description: "10-16 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Legs, Core, Shoulders",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Duration",
                  description: "10-15 mins",
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

            // How to Perform Jump Rope
            Text(
              "How to Perform Jump Rope:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Stand tall with your feet together, holding the rope handles in each hand."),
            BulletPoint(text: "Position the rope behind you, resting it on the ground."),
            BulletPoint(text: "Use your wrists to swing the rope over your head and jump just high enough to clear it."),
            BulletPoint(text: "Land softly on the balls of your feet and immediately repeat the motion."),
            BulletPoint(text: "Maintain a steady pace, and keep your core engaged for balance."),
            BulletPoint(text: "Focus on minimal arm movement and keep the rotation coming from your wrists."),

            SizedBox(height: 16),

            // Benefits of Jump Rope
            Text(
              "Benefits of Jump Rope:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Burns a high number of calories, making it ideal for weight loss."),
            BulletPoint(text: "Improves cardiovascular health and overall stamina."),
            BulletPoint(text: "Enhances coordination, balance, and agility."),
            BulletPoint(text: "Strengthens lower body muscles, including calves, hamstrings, and quads."),
            BulletPoint(text: "Tones the shoulders and arms as you swing the rope."),

            SizedBox(height: 16),

            // Jump Rope Variations
            Text(
              "Jump Rope Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Basic Jump: The standard jump rope technique for beginners."),
            BulletPoint(text: "Alternate Foot Jump: Alternate lifting each foot as if you’re running in place."),
            BulletPoint(text: "High Knees Jump: Lift your knees higher with each jump for added intensity."),
            BulletPoint(text: "Double Unders: Swing the rope twice under your feet with one jump for a challenge."),
            BulletPoint(text: "Criss-Cross: Cross the rope handles in front of you while jumping for coordination."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Jump Rope Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Warm up your muscles with dynamic stretches before jumping rope."),
            BulletPoint(text: "Choose a jump rope that is the correct length for your height."),
            BulletPoint(text: "Wear supportive footwear to reduce the impact on your feet and joints."),
            BulletPoint(text: "Perform on a shock-absorbing surface to minimize joint strain."),
            BulletPoint(text: "Start with short sessions and gradually increase duration to avoid fatigue."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Jump rope is a versatile and effective cardio workout that not only burns calories but also improves your athletic skills. It’s a fun and efficient way to stay fit, build endurance, and elevate your overall fitness level. Grab a rope, set a timer, and get ready to jump your way to better health!",
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
