import 'package:flutter/material.dart';

class FoodDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guacamole'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Guacamole',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset('assets/images/guacamole.jpg'), // Placeholder for image
            SizedBox(height: 20),
            SectionTitle('How to Make Guacamole'),
            Text(
              '1. Mash ripe avocados in a bowl.\n'
              '2. Add diced onions, tomatoes, and cilantro.\n'
              '3. Squeeze lime juice over the mix and add salt.\n'
              '4. Mix everything until well combined.\n'
              '5. Serve fresh!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Ingredients'),
            Text(
              '- 2 ripe avocados\n'
              '- 1/4 cup diced onions\n'
              '- 1/4 cup diced tomatoes\n'
              '- Fresh cilantro\n'
              '- 1 lime\n'
              '- Salt to taste',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Calories'),
            Text(
              'Approximately 240 calories per 100g.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Health Benefits'),
            Text(
              '• High in healthy fats (monounsaturated fats)\n'
              '• Rich in fiber, helps digestion\n'
              '• Contains vitamins C, E, K, and B6\n'
              '• Loaded with potassium, which supports heart health\n'
              '• Helps to reduce cholesterol levels',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Guacamole is suitable for most people, especially those on a keto, vegan, or Mediterranean diet. However, people with avocado allergies should avoid it.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Enjoy guacamole as a snack or a side with meals. It’s especially beneficial as a pre- or post-workout snack due to its healthy fats and potassium.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Guacamole is best served fresh. Refrigerate leftovers in an airtight container to prevent browning and consume within 1–2 days for optimal flavor.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green[800]),
      ),
    );
  }
}