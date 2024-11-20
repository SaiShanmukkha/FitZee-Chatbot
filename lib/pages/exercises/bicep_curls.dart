import 'package:flutter/material.dart';

class BicepCurlDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bicep Curls: Build Strong Arms 💪'),
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
                'assets/images/bicep_curls.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Bicep Curls: The Key to Strong, Defined Arms 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Bicep curls are one of the most popular exercises for building muscle and strength in your upper arms. This exercise specifically targets the biceps — the muscles on the front of your upper arm, helping you achieve stronger and more defined arms. Bicep curls can be performed with dumbbells, barbells, or cables, making them versatile and easy to incorporate into any workout routine.",
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
                  description: "Biceps, Forearms",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 10-12 reps",
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

            // How to Perform Bicep Curls
            Text(
              "How to Perform a Bicep Curl:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Stand with your feet shoulder-width apart, holding a dumbbell in each hand with your arms fully extended."),
            BulletPoint(
                text: "Keep your elbows close to your torso and your palms facing forward (supinated grip)."),
            BulletPoint(
                text: "Curl the weights upwards by bending your elbows, bringing the dumbbells toward your shoulders."),
            BulletPoint(
                text: "Focus on contracting your biceps as you lift the weights, keeping your elbows stationary."),
            BulletPoint(
                text: "Pause at the top, then slowly lower the dumbbells back to the starting position, controlling the descent."),

            SizedBox(height: 16),

            // Benefits of Bicep Curls
            Text(
              "Why Bicep Curls Are Essential:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Builds bicep strength and size, enhancing the appearance of the upper arm."),
            BulletPoint(
                text: "Improves grip strength, which benefits other lifts and daily activities."),
            BulletPoint(
                text: "Enhances overall arm definition and symmetry."),
            BulletPoint(
                text: "Easy to modify with different weights, making them suitable for all fitness levels."),
            BulletPoint(
                text: "Great for isolating the biceps without requiring complex movements or equipment."),

            SizedBox(height: 16),

            // Bicep Curl Variations
            Text(
              "Bicep Curl Variations to Spice Up Your Routine:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Hammer Curl: Palms facing each other, this targets both the biceps and forearms."),
            BulletPoint(
                text: "Concentration Curl: Performed one arm at a time to fully isolate the biceps."),
            BulletPoint(
                text: "Barbell Curl: Uses a barbell, allowing you to lift heavier weights and work both arms at once."),
            BulletPoint(
                text: "Preacher Curl: Performed on a preacher bench, this isolates the biceps and minimizes cheating."),
            BulletPoint(
                text: "Cable Curl: Uses a cable machine, offering constant tension throughout the movement."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Bicep Curl Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Start with moderate weights and increase gradually as you become stronger."),
            BulletPoint(
                text: "Avoid swinging your body to lift the weights. Focus on controlled movement."),
            BulletPoint(
                text: "Keep your wrists straight and avoid bending them excessively during the curl."),
            BulletPoint(
                text: "Always warm up your muscles before performing curls to prevent injury."),
            BulletPoint(
                text: "If you're using heavy weights, use a spotter or consider machine alternatives for safety."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Bicep curls are one of the simplest yet most effective exercises for building arm strength and muscle. With a focus on controlled movements and consistency, bicep curls can help you develop stronger, more defined arms that enhance both aesthetics and strength.",
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
