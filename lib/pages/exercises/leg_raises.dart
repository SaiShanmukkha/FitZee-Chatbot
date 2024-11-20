import 'package:flutter/material.dart';

class LegRaisesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leg Raises: Tone Your Core 🔥'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/leg_raises.gif', // Make sure the image is correctly added in your assets folder
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Leg Raises: Tone Your Core 🔥",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Leg raises are an excellent exercise for strengthening your core, specifically targeting the lower abdominal muscles. This exercise also engages your hip flexors and can be modified to increase or decrease difficulty depending on your fitness level.",
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
                  color: Colors.orange,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Abs, Hip Flexors",
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 12-15 reps",
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

            // How to Perform Leg Raises
            Text(
              "How to Perform Leg Raises:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Lie flat on your back on the floor or a mat with your arms at your sides."),
            BulletPoint(text: "Keep your legs straight and together while maintaining a slight bend in your knees."),
            BulletPoint(text: "Engage your core and slowly raise your legs towards the ceiling, keeping them straight."),
            BulletPoint(text: "Pause for a moment at the top of the movement, then slowly lower your legs back down, stopping just above the ground."),
            BulletPoint(text: "Avoid letting your lower back arch, and keep your abs engaged throughout the movement."),

            SizedBox(height: 16),

            // Benefits of Leg Raises
            Text(
              "Benefits of Leg Raises:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Strengthens the lower abs and improves overall core stability."),
            BulletPoint(text: "Engages the hip flexors and helps in building flexibility in the lower body."),
            BulletPoint(text: "Improves posture by strengthening the core muscles, which support the spine."),
            BulletPoint(text: "Helps in toning the legs and improves overall muscle endurance."),
            BulletPoint(text: "Enhances balance and stability, which is important for various physical activities."),

            SizedBox(height: 16),

            // Leg Raise Variations
            Text(
              "Leg Raise Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Hanging Leg Raises: Performed while hanging from a bar to increase difficulty."),
            BulletPoint(text: "Bent-Knee Leg Raises: A slightly easier variation, good for beginners."),
            BulletPoint(text: "Flutter Kicks: Alternate raising each leg for a more dynamic movement."),
            BulletPoint(text: "Toe-Touch Leg Raises: Raise legs and touch your toes to add a crunch element to the exercise."),
            BulletPoint(text: "Weighted Leg Raises: Hold a weight between your feet to increase resistance."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Leg Raise Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Keep your lower back pressed against the floor to avoid straining it."),
            BulletPoint(text: "Engage your core throughout the exercise to protect your spine."),
            BulletPoint(text: "Avoid swinging your legs too fast, as this reduces the effectiveness of the exercise."),
            BulletPoint(text: "If you feel pain in your lower back, stop the exercise and check your form."),
            BulletPoint(text: "Take adequate rest between sets to avoid overtraining the muscles."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "Leg raises are a powerful exercise for anyone looking to improve their core strength and tone their abdominal muscles. Whether you're a beginner or more advanced, there are plenty of variations to make this exercise suitable for your fitness level. Consistency and proper form are key to seeing the best results. Start incorporating leg raises into your workout routine for a stronger, more toned core!",
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
