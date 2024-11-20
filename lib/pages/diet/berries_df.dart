import 'package:flutter/material.dart';

class BerriesDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berries Details'),
        backgroundColor: Colors.purple[800], // AppBar background color for Berries
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
                    'Berries',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/berries.jpg',
                      height: 200), // Placeholder for berries image
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
                InfoBox('Calories', '50–60 kcal/100g'),
                InfoBox('Carbs', '12–15g'),
                InfoBox('Fiber', '3–5g'),
                InfoBox('Vitamin C', 'High content'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Examples of Berries'),
            Text(
              '- Strawberries\n'
              '- Blueberries\n'
              '- Raspberries\n'
              '- Blackberries\n'
              '- Cranberries\n'
              '- Goji Berries',
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
              childAspectRatio: 2,
              children: [
                InfoBox('Antioxidants', 'Fights free radicals'),
                InfoBox('Fiber', 'Promotes digestion'),
                InfoBox('Low Calories', 'Supports weight management'),
                InfoBox('Vitamin C', 'Boosts immune health'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Berries are versatile and can be enjoyed as part of breakfast, snacks, or desserts. Add them to smoothies, oatmeal, yogurt, or salads.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Berries are suitable for almost everyone, including those on low-calorie or low-sugar diets. However, individuals with specific allergies or sensitivities should choose options carefully.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Berries are best consumed fresh or frozen to retain their nutritional value. Store them in the refrigerator and wash them thoroughly before eating.',
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
            color: Colors.purple[800]),
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
      height: 80, // Adjust this height as per your preference
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[300]!),
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
                color: Colors.purple[700]),
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

