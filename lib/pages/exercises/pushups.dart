import 'package:flutter/material.dart';

class PushUpDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Your Push-Ups! 💪'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eye-Catching GIF
            Center(
              child: Image.asset(
                'assets/images/pushups.gif',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Fun and Engaging Introduction
            Text(
              'Push-ups are the undisputed kings of bodyweight exercises! 🏆 They sculpt your chest, define your arms, and even strengthen your core—all without needing fancy equipment or a gym membership.',
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
                  description: '7 cal/min for a 155 lb person',
                  icon: Icons.local_fire_department,
                  color: Colors.redAccent,
                ),
                InfoBox(
                  title: '💪 Muscles Worked',
                  description: 'Chest, shoulders, triceps, core',
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
                  description: 'Beginner to pro level',
                  icon: Icons.shuffle,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),

            // How to Do a Push-Up (Lively Tone)
            Text(
              'How to Nail the Perfect Push-Up:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '1️⃣ Start face down on the floor, hands shoulder-width apart.'),
            BulletPoint(text: '2️⃣ Feet together or a bit apart, balance on the balls of your feet.'),
            BulletPoint(text: '3️⃣ Keep your body as straight as a board—no sagging or arching!'),
            BulletPoint(text: '4️⃣ Lower yourself slowly, elbows at 45 degrees, until you almost kiss the floor.'),
            BulletPoint(text: '5️⃣ Push back up with power, and don’t lock those elbows at the top!'),
            SizedBox(height: 16),

            // Benefits (Keep It Motivational!)
            Text(
              'Why Push-Ups Rock:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '💥 Strengthen your chest, shoulders, and triceps like a boss.'),
            BulletPoint(text: '🦵 Engage your core for abs of steel (or close to it!).'),
            BulletPoint(text: '🚀 Do them anywhere—your living room, the park, even on vacation!'),
            BulletPoint(text: '❤️ High-rep sets get your heart pumping, boosting your cardio.'),
            BulletPoint(text: '🎯 Build real-life strength for pushing, lifting, and superhero feats.'),
            SizedBox(height: 16),

            // Push-Up Variations (Challenge Yourself)
            Text(
              'Push-Up Variations to Keep Things Spicy:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '🔹 Knee Push-Ups: Perfect for beginners.'),
            BulletPoint(text: '🔹 Wide-Grip Push-Ups: Smash those chest muscles.'),
            BulletPoint(text: '🔹 Diamond Push-Ups: Triceps on fire!'),
            BulletPoint(text: '🔹 Decline Push-Ups: Feet up, upper chest burning.'),
            BulletPoint(text: '🔹 Plyometric Push-Ups: Explosive power with claps in between!'),
            SizedBox(height: 16),

            // Safety and Recovery (Be Smart!)
            Text(
              'Safety First, Always:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            BulletPoint(text: '🧘‍♂️ Warm up those muscles to stay injury-free.'),
            BulletPoint(text: '🤔 Quality > Quantity: Form is everything.'),
            BulletPoint(text: '💡 If it hurts, stop! Try wrist-friendly variations.'),
            BulletPoint(text: '🛌 Give your muscles rest days for proper recovery.'),
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

  InfoBox({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// BulletPoint Widget with Style
class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }
}
