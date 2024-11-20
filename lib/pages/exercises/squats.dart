import 'package:flutter/material.dart';

class SquatsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Your Squats! 🏋️'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eye-Catching GIF
            Center(
              child: Image.asset(
                'assets/images/squats.gif',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Fun and Engaging Introduction
            Text(
              'Squats are the secret weapon for strong legs and a powerful core! 🍑 From boosting athletic performance to sculpting your lower body, squats are a must-have in your fitness routine.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // 4 Key Factors in a 2x2 Fun Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                InfoBox(
                  title: '🔥 Burn Rate',
                  description: '5-8 cal/min for a 155 lb person',
                  icon: Icons.local_fire_department,
                  color: Colors.redAccent,
                ),
                InfoBox(
                  title: '💪 Muscles Worked',
                  description: 'Quads, glutes, hamstrings, core',
                  icon: Icons.fitness_center,
                  color: Colors.blueAccent,
                ),
                InfoBox(
                  title: '🌍 Anywhere',
                  description: 'No equipment needed!',
                  icon: Icons.location_on,
                  color: Colors.green,
                ),
                InfoBox(
                  title: '🔄 Variations',
                  description: 'Bodyweight to weighted squats',
                  icon: Icons.shuffle,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Do a Squat (Lively Tone)
            Text(
              'How to Master the Squat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '1️⃣ Stand tall with your feet shoulder-width apart.'),
            BulletPoint(text: '2️⃣ Engage your core and keep your chest lifted.'),
            BulletPoint(text: '3️⃣ Push your hips back and bend your knees like you’re sitting on an invisible chair.'),
            BulletPoint(text: '4️⃣ Lower down until your thighs are parallel to the floor—or go deeper if you’re feeling bold!'),
            BulletPoint(text: '5️⃣ Press through your heels to stand back up.'),
            SizedBox(height: 16),

            // Benefits (Keep It Motivational!)
            Text(
              'Why Squats Are Game-Changers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '💥 Strengthen your quads, glutes, and hamstrings for powerful legs.'),
            BulletPoint(text: '⚖️ Boost balance and core stability—goodbye, wobbles!'),
            BulletPoint(text: '🚀 Do them anywhere—at home, the gym, or even in the office (just maybe not during a meeting).'),
            BulletPoint(text: '🎯 Tone your lower body and lift your booty to new heights.'),
            BulletPoint(text: '❤️ Improve joint health by strengthening knees and hips.'),
            SizedBox(height: 16),

            // Squat Variations (Challenge Yourself)
            Text(
              'Squat Variations to Mix It Up:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '🔹 Goblet Squats: Hold a dumbbell for extra weight.'),
            BulletPoint(text: '🔹 Sumo Squats: Wide stance to target the inner thighs.'),
            BulletPoint(text: '🔹 Jump Squats: Explosive power with a hop at the top.'),
            BulletPoint(text: '🔹 Single-Leg Squats: Balance and strength in one move.'),
            BulletPoint(text: '🔹 Wall Sits: Static hold for a burn that won’t quit!'),
            SizedBox(height: 16),

            // Safety and Recovery (Be Smart!)
            Text(
              'Safety First, Always:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '🧘‍♂️ Warm up those legs to avoid muscle strains.'),
            BulletPoint(text: '🤔 Knees over toes? It’s okay, but be mindful!'),
            BulletPoint(text: '💡 Go at your own pace and keep that form solid.'),
            BulletPoint(text: '🛌 Rest those legs for muscle recovery and growth.'),
          ],
        ),
      ),
    );
  }
}

// InfoBox Widget for 2x2 Grid with Colors
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
