import 'package:flutter/material.dart';

class GreekYogurtDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greek Yogurt Details'),
        backgroundColor: Colors.lightBlue[800], // AppBar background color for Greek Yogurt
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
                    'Greek Yogurt',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/greek_yogurt.jpg',
                      height: 200), // Placeholder for Greek yogurt image
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
                InfoBox('Calories', '100–150 kcal/100g'),
                InfoBox('Protein', '10g'),
                InfoBox('Carbs', '3–5g'),
                InfoBox('Fat', '0–5g (depends on type)'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Health Benefits'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2, 
              children: [
                InfoBox('High Protein', 'Supports muscle growth'),
                InfoBox('Probiotics', 'Improves gut health'),
                InfoBox('Calcium', 'Strengthens bones'),
                InfoBox('Low Sugar', 'Supports weight management'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Greek yogurt is great as part of breakfast, snacks, or desserts. It pairs well with fruits, granola, or honey for added flavor and nutrition.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Greek yogurt is suitable for most people, including those looking for high-protein, low-sugar options. Lactose-sensitive individuals should opt for lactose-free varieties.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Store Greek yogurt in the refrigerator and consume it within the expiration date. Avoid mixing with high-sugar ingredients to retain its health benefits.',
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
            color: Colors.lightBlue[800]),
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
      height: 80, // Adjusted height for better appearance
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.lightBlue[300]!),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.lightBlue[700]),
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
