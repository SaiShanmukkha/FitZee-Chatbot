import 'package:flutter/material.dart';

class DeadliftDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deadlift: Power and Strength Exercise 🏋️'),
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
                'assets/images/deadlift.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Deadlifts: The King of Strength Training! 🏋️‍♂️",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Deadlifts are a compound strength exercise that primarily targets your posterior chain — the muscles along the back of your body, such as the glutes, hamstrings, lower back, and traps. It is one of the most effective exercises for building raw strength, enhancing posture, and boosting overall fitness.",
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
                  description: "4-7 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Glutes, Hamstrings, Back",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-5 sets of 5 reps",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Difficulty Level",
                  description: "High",
                  icon: Icons.flash_on,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Deadlift
            Text(
              "How to Perform a Deadlift:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Stand with your feet hip-width apart, with the barbell over the middle of your feet."),
            BulletPoint(
                text: "Bend at your hips and knees, gripping the barbell with hands just outside your knees."),
            BulletPoint(
                text: "Keep your chest up, back straight, and core engaged, maintaining a neutral spine."),
            BulletPoint(
                text: "Push through your heels to lift the barbell, standing tall and keeping the bar close to your body."),
            BulletPoint(
                text: "Lower the barbell back down with control, bending at the hips and knees to return to the starting position."),

            SizedBox(height: 16),

            // Benefits of Deadlifts
            Text(
              "Why Deadlifts Are Essential:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Builds total body strength, focusing on your posterior chain (backside muscles)."),
            BulletPoint(
                text: "Improves posture and spinal alignment by strengthening the lower back."),
            BulletPoint(
                text: "Enhances athletic performance and functional strength for daily tasks."),
            BulletPoint(
                text: "Boosts calorie burn due to the intensity and involvement of large muscle groups."),
            BulletPoint(
                text: "Helps with muscle hypertrophy, improving both strength and muscle mass."),

            SizedBox(height: 16),

            // Deadlift Variations
            Text(
              "Deadlift Variations to Boost Your Routine:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Sumo Deadlift: A wider stance with feet turned outward targets your inner thighs."),
            BulletPoint(
                text: "Romanian Deadlift: Focuses more on the hamstrings and glutes with a slightly different motion."),
            BulletPoint(
                text: "Trap Bar Deadlift: A safer alternative with a hexagonal barbell, reducing strain on your lower back."),
            BulletPoint(
                text: "Single-Leg Deadlift: Adds balance and core stability while targeting the hamstrings."),
            BulletPoint(
                text: "Deficit Deadlift: Performed on an elevated surface to increase the range of motion and challenge your strength."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Deadlift Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text: "Always warm up before lifting to activate muscles and prevent injuries."),
            BulletPoint(
                text: "Focus on proper form: keep your back straight, chest up, and shoulders engaged."),
            BulletPoint(
                text: "Start with lighter weights and gradually increase as you master the technique."),
            BulletPoint(
                text: "Avoid rounding your back when lifting — engage your core and keep your spine neutral."),
            BulletPoint(
                text: "Use lifting straps or chalk for grip support if you’re lifting heavy weights."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Deadlifts are one of the most powerful exercises to enhance overall strength, power, and performance. With consistent practice and attention to form, deadlifts can be an essential part of any strength training routine, providing numerous benefits for both beginners and advanced athletes.",
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
