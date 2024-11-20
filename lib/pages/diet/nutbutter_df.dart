import 'package:flutter/material.dart';

class NutsAndNutButterDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuts and Nut Butter Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[800],
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
                    'Nuts and Nut Butter',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/nuts.jpg',
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
                InfoBox('Calories', '580 kcal/100g (varies)'),
                InfoBox('Protein', '20–25g'),
                InfoBox('Carbs', '10–12g'),
                InfoBox('Fat', '50–60g (healthy fats)'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Common Types'),
            Text(
              '- Almonds\n'
              '- Walnuts\n'
              '- Cashews\n'
              '- Peanuts\n'
              '- Peanut Butter\n'
              '- Almond Butter',
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
                InfoBox('Healthy Fats', 'Good for heart health'),
                InfoBox('Protein', 'Supports muscle growth'),
                InfoBox('Fiber', 'Aids digestion'),
                InfoBox('Vitamin E', 'Boosts skin health'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Great as a snack, pre- or post-workout, or added to meals for an energy boost.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Suitable for most diets, including keto, vegetarian, and Mediterranean. Not recommended for individuals with nut allergies.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Store in a cool, dry place to maintain freshness. Nut butters should be stored in an airtight container to prevent oil separation.',
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
            color: Colors.brown[800]),
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
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.brown[300]!),
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
                color: Colors.brown[700]),
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
