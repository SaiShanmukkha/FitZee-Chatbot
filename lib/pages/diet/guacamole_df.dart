import 'package:flutter/material.dart';

class GuacamoleDietFoodDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guacamole Details'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Guacamole',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/guacamole.jpg',
                      height: 200), // Placeholder for image
                ],
              ),
            ),
            SizedBox(height: 20),
            SectionTitle('Nutritional Content'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                InfoBox('Calories', '240 kcal/100g'),
                InfoBox('Protein', '2g'),
                InfoBox('Carbs', '12g'),
                InfoBox('Fat', '22g (healthy fats)'),
              ],
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
            SectionTitle('Health Benefits'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                InfoBox('Fiber', 'Aids digestion'),
                InfoBox('Vitamins', 'C, E, K, B6'),
                InfoBox('Potassium', 'Good for heart health'),
                InfoBox('Fats', 'Reduces cholesterol'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Enjoy as a snack or side with meals. Great as a pre- or post-workout snack due to healthy fats and potassium.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Suitable for keto, vegan, and Mediterranean diets. Not recommended for people with avocado allergies.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Best served fresh. Store leftovers in an airtight container to prevent browning and consume within 1–2 days.',
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
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green[800]),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String content;
  InfoBox(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[300]!),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green[700]),
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
