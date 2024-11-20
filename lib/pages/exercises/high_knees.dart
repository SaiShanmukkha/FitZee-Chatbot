import 'package:flutter/material.dart';

class HighKneesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Knees: Boost Your Cardio & Leg Strength 🦵'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/high_knees.gif', // Ensure the image is correctly placed in assets/images
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "High Knees: Boost Your Cardio & Leg Strength 🦵",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "High knees are an intense cardio exercise that elevate your heart rate while engaging your lower body muscles. This exercise helps improve your cardiovascular endurance, builds leg strength, and enhances coordination. Whether you're warming up or performing them as part of a high-intensity workout, high knees are a fantastic full-body exercise.",
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
                  description: "8-10 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Quadriceps, Glutes, Core",
                  icon: Icons.fitness_center,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Ideal Reps",
                  description: "3-4 sets of 30 seconds",
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Difficulty Level",
                  description: "Medium-High",
                  icon: Icons.flash_on,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform High Knees
            Text(
              "How to Perform High Knees:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Start by standing with your feet hip-width apart, arms by your sides."),
            BulletPoint(text: "Lift your right knee toward your chest, keeping your core tight."),
            BulletPoint(text: "As you lower your right leg, simultaneously lift your left knee."),
            BulletPoint(text: "Continue alternating legs rapidly, as if you're running in place, keeping a fast pace."),
            BulletPoint(text: "Maintain a slight bend in your elbows and pump your arms for better coordination."),
            BulletPoint(text: "Ensure that your back remains straight and your posture is upright throughout the movement."),

            SizedBox(height: 16),

            // Benefits of High Knees
            Text(
              "Benefits of High Knees:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Improves cardiovascular endurance and stamina."),
            BulletPoint(text: "Strengthens the quadriceps, glutes, and core muscles."),
            BulletPoint(text: "Boosts calorie burning and fat loss, especially when performed at high intensity."),
            BulletPoint(text: "Enhances coordination and agility, important for various sports."),
            BulletPoint(text: "Improves lower body strength and explosive power for athletic performance."),

            SizedBox(height: 16),

            // High Knees Variations
            Text(
              "High Knees Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Slow High Knees: Perform at a moderate pace for a longer duration."),
            BulletPoint(text: "Jumping High Knees: Add a hop with each knee raise for added intensity."),
            BulletPoint(text: "High Knees with Resistance Bands: Use resistance bands around your legs to add more resistance."),
            BulletPoint(text: "Sprint High Knees: Perform at maximum speed for short bursts of intense activity."),
            BulletPoint(text: "High Knees to Burpees: Combine high knees with burpees for a full-body, high-intensity workout."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "High Knees Safety Tips:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(text: "Warm up before starting high knees to prepare your muscles for the intense activity."),
            BulletPoint(text: "Maintain proper posture to prevent strain on your back and knees."),
            BulletPoint(text: "Perform the movement at a pace suitable for your fitness level. Start slow if you're a beginner."),
            BulletPoint(text: "Avoid excessive bouncing or jarring motions that can cause discomfort in your knees."),
            BulletPoint(text: "If you feel any discomfort or pain in your joints, stop the exercise and consult a professional."),

            SizedBox(height: 16),

            // Conclusion
            Text(
              "High Knees are a fantastic cardio and leg-strengthening exercise that can be easily incorporated into any workout routine. Whether you're using them to warm up or for high-intensity interval training (HIIT), they are effective for improving cardiovascular fitness, building lower body strength, and boosting coordination. Challenge yourself with different variations and enjoy the benefits of this simple but powerful exercise.",
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
