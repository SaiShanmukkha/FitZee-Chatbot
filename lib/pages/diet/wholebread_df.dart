import 'package:flutter/material.dart';

class WholeGrainBreadDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whole-Grain Bread Details'),
        backgroundColor: const Color.fromARGB(255, 180, 212, 115),
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
                    'Whole-Grain Bread',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/whole_grain_bread.jpg',
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
                InfoBox('Calories', '250 kcal/100g'),
                InfoBox('Protein', '10–12g'),
                InfoBox('Carbs', '45–50g'),
                InfoBox('Fiber', '6–8g'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Key Ingredients'),
            Text(
              '- Whole-wheat flour\n'
              '- Water\n'
              '- Yeast\n'
              '- Salt\n'
              '- Optional: seeds (chia, flax, sunflower)',
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
                InfoBox('High Fiber', 'Aids digestion & gut health'),
                InfoBox('Complex Carbs', 'Provides sustained energy'),
                InfoBox('Protein', 'Supports muscle repair'),
                InfoBox('Micronutrients', 'Rich in B vitamins'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Ideal for breakfast or as a part of meals. Great for sandwiches, toast, or as a side with soups and salads.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Suitable for most diets, including vegetarian and balanced eating plans. Not suitable for those with gluten intolerance or celiac disease unless gluten-free options are used.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Store in a cool, dry place or refrigerate for longer freshness. Best consumed within 3–5 days of baking for optimal taste and texture.',
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
