import 'package:flutter/material.dart';

class LungesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lunge Like a Pro! 🦵'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Center(
              child: Image.asset(
                'assets/images/lunges.gif', // Ensure the asset is added in your project
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Introductory Description
            Text(
              "Lunges: Your Go-To Move for Stronger Legs!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Lunges are a versatile lower body exercise that target the quads, glutes, hamstrings, and calves. They're perfect for improving balance, coordination, and overall lower body strength. Let’s get lunging!",
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
                  description: "6-9 per min",
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                InfoBox(
                  title: "Muscles Worked",
                  description: "Quads, Glutes",
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                InfoBox(
                  title: "Ideal Form",
                  description: "90° Knees",
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                InfoBox(
                  title: "Intensity Level",
                  description: "Moderate-High",
                  icon: Icons.speed,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Perform Lunges
            Text(
              "How to Perform Lunges:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Start by standing tall with your feet hip-width apart and hands on your hips."),
            BulletPoint(
                text:
                    "Take a big step forward with your right foot, and lower your hips until both knees are bent at about a 90-degree angle."),
            BulletPoint(
                text:
                    "Ensure your front knee is directly above your ankle and your back knee hovers just above the ground."),
            BulletPoint(
                text:
                    "Push through your front heel to return to the starting position. Repeat on the other leg."),

            SizedBox(height: 16),

            // Benefits of Lunges
            Text(
              "Why Lunges Rock:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Strengthen major lower body muscles: quads, hamstrings, glutes, and calves."),
            BulletPoint(
                text:
                    "Improve balance and coordination, essential for athletic performance."),
            BulletPoint(
                text:
                    "Great for functional fitness, helping you with everyday movements like climbing stairs."),
            BulletPoint(
                text:
                    "Can be performed anywhere, no equipment needed (but can be spiced up with weights!)."),

            SizedBox(height: 16),

            // Variations of Lunges
            Text(
              "Lunge Variations to Try:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Reverse Lunges: Step backward instead of forward for a different challenge."),
            BulletPoint(
                text:
                    "Walking Lunges: Move forward with each lunge to engage your core and improve coordination."),
            BulletPoint(
                text:
                    "Side Lunges: Target your inner and outer thighs by lunging to the side."),
            BulletPoint(
                text:
                    "Curtsy Lunges: Step one leg behind the other in a diagonal motion for a glute-focused burn."),

            SizedBox(height: 16),

            // Safety and Precautions
            Text(
              "Stay Safe and Injury-Free:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            BulletPoint(
                text:
                    "Warm-up your legs before lunging to get your muscles ready for action."),
            BulletPoint(
                text:
                    "Keep your core engaged and maintain an upright torso to avoid straining your lower back."),
            BulletPoint(
                text:
                    "If you have knee issues, consider doing partial lunges or consult a professional."),
            BulletPoint(
                text:
                    "Listen to your body and don’t overdo it; allow proper rest and recovery."),

            SizedBox(height: 16),
            // Conclusion
            Text(
              "Lunges are a fantastic way to strengthen your legs, improve stability, and boost overall athleticism. Mix them into your routine, and your lower body will thank you!",
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
