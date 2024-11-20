import 'package:flutter/material.dart';

class ShoulderPressDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoulder Press: Build Strong Shoulders 💪'),
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
                'assets/images/shoulder_press.gif', // Ensure the image is correctly placed in assets/images
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Shoulder Press: Build Strong Shoulders 💪",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "The Shoulder Press is an effective and essential exercise for building strong, toned shoulders and arms. It primarily targets the deltoid muscles while also engaging the triceps and upper chest. Whether you're a beginner or experienced lifter, shoulder presses can be easily adapted to suit your fitness level.",
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
                  description: "Deltoids, Triceps",
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

            // How to Perform Shoulder Press
            Text(
              "How to Perform the Shoulder Press:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Start by sitting or standing with a dumbbell in each hand at shoulder height."),
            BulletPoint(text: "Keep your feet shoulder-width apart and engage your core."),
            BulletPoint(text: "Press the dumbbells overhead until your arms are fully extended, palms facing forward."),
            BulletPoint(text: "Slowly lower the dumbbells back to shoulder height, maintaining control."),
            BulletPoint(text: "Ensure your elbows are slightly in front of your body, not flaring out to the sides."),
            BulletPoint(text: "Keep your back straight and avoid arching your lower back during the press."),

            SizedBox(height: 16),

            // Benefits of Shoulder Press
            Text(
              "Benefits of Shoulder Press:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Builds strong and toned shoulders, improving overall upper body strength."),
            BulletPoint(text: "Engages multiple upper body muscles, including the triceps and upper chest."),
            BulletPoint(text: "Improves posture by strengthening the muscles around the shoulder girdle."),
            BulletPoint(text: "Enhances shoulder mobility and stability."),
            BulletPoint(text: "Helps increase functional strength for pushing movements in daily life and sports."),

            SizedBox(height: 16),

            // Shoulder Press Variations
            Text(
              "Shoulder Press Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Dumbbell Shoulder Press: A classic version using two dumbbells."),
            BulletPoint(text: "Barbell Shoulder Press: Perform with a barbell for greater weight and intensity."),
            BulletPoint(text: "Arnold Press: A variation where you rotate your palms while pressing the weight overhead."),
            BulletPoint(text: "Seated Shoulder Press: Perform while seated to focus on the shoulder muscles without using momentum."),
            BulletPoint(text: "Push Press: Use your legs to assist in pressing the weight overhead for an explosive movement."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Shoulder Press Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Always maintain a neutral spine and avoid arching your back excessively."),
            BulletPoint(text: "Control the movement both up and down to avoid jerking or using momentum."),
            BulletPoint(text: "Start with lighter weights to ensure proper form and avoid strain."),
            BulletPoint(text: "If you experience any shoulder discomfort, stop the exercise and consult a professional."),
            BulletPoint(text: "Focus on quality over quantity to maximize muscle engagement and minimize injury risk."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "The Shoulder Press is a staple in any upper body strength routine, offering significant benefits for the deltoids, triceps, and overall posture. With proper form and consistency, you'll build stronger shoulders, improve your pushing strength, and enhance functional fitness for daily life.",
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
