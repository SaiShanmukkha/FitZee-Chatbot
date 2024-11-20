import 'package:flutter/material.dart';

class RussianTwistsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Russian Twists: Sculpt Your Waist 🔥'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/russian_twists.gif', // Ensure the image is correctly placed in assets/images
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Russian Twists: Sculpt Your Waist 🔥",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Russian Twists are a dynamic core exercise that targets the obliques and helps in building a sculpted, toned waist. The twisting motion not only strengthens the core but also improves rotational movement, which is essential for various functional activities.",
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
                  description: "6-8 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Obliques, Abs",
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 20-30 twists",
                  icon: Icons.timer,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Difficulty Level",
                  description: "Medium",
                  icon: Icons.flash_on,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Russian Twists
            Text(
              "How to Perform Russian Twists:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Sit on the floor with your knees bent and feet flat, or elevate your feet for more challenge."),
            BulletPoint(
                text:
                    "Lean back slightly while keeping your back straight, engaging your core."),
            BulletPoint(
                text:
                    "Hold your hands together in front of you, or hold a weight for added resistance."),
            BulletPoint(
                text:
                    "Rotate your torso to one side, bringing your hands beside your hip."),
            BulletPoint(
                text:
                    "Return to the center and twist to the other side. Alternate sides to complete one repetition."),
            BulletPoint(
                text:
                    "Keep your legs still and focus on twisting from your waist and engaging the obliques."),

            SizedBox(height: 16),

            // Benefits of Russian Twists
            Text(
              "Benefits of Russian Twists:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Targets the obliques and helps build a defined waistline."),
            BulletPoint(
                text:
                    "Strengthens the entire core, improving stability and posture."),
            BulletPoint(
                text:
                    "Improves rotational movement, which is essential for daily activities."),
            BulletPoint(
                text:
                    "Helps in enhancing flexibility and mobility in the spine."),
            BulletPoint(
                text:
                    "Engages multiple muscle groups, including the abs, obliques, and lower back."),

            SizedBox(height: 16),

            // Russian Twist Variations
            Text(
              "Russian Twist Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Weighted Russian Twists: Hold a dumbbell or medicine ball for extra resistance."),
            BulletPoint(
                text:
                    "Feet Elevated: Lift your feet off the ground to increase core engagement."),
            BulletPoint(
                text:
                    "Side to Side: Keep your feet planted and twist side to side, without lifting your feet."),
            BulletPoint(
                text:
                    "Russian Twist with Crunch: Add a crunch at the top of each twist for more abdominal engagement."),
            BulletPoint(
                text:
                    "Medicine Ball Slams: Combine the twist with a slam for an added challenge."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Russian Twist Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Keep your back straight and avoid slouching to prevent strain."),
            BulletPoint(
                text:
                    "Do not jerk or force the movement; instead, control the twist with your core."),
            BulletPoint(
                text:
                    "If you experience lower back pain, stop and reassess your form."),
            BulletPoint(
                text:
                    "Start with a lighter weight or no weight and gradually increase the resistance as you become stronger."),
            BulletPoint(
                text:
                    "Focus on the quality of the movement rather than speed for better results."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Russian Twists are a fantastic exercise for anyone looking to improve their core strength, flexibility, and rotational power. They are simple to perform and can be modified to fit your fitness level. With consistency and proper form, you'll see improvements in your waistline and overall core strength!",
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
