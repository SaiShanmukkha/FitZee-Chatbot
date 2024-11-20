import 'package:flutter/material.dart';

class LeanProteinDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lean Protein Details'),
        backgroundColor: Colors.blue[800], // AppBar background color for Lean Protein
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
                    'Lean Protein',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/lean_protein.jpg',
                      height: 200), // Placeholder for lean protein image
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
                InfoBox('Calories', 'Varies by source'),
                InfoBox('Protein', 'High content'),
                InfoBox('Fat', 'Low content'),
                InfoBox('Carbs', 'Low to none'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Examples of Lean Protein Sources'),
            Text(
              '- Skinless poultry (chicken, turkey)\n'
              '- Fish (cod, tilapia, salmon)\n'
              '- Legumes (lentils, chickpeas)\n'
              '- Low-fat dairy (Greek yogurt, cottage cheese)\n'
              '- Plant-based proteins (tofu, tempeh)',
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
                InfoBox('Muscle Maintenance', 'Supports muscle growth and repair'),
                InfoBox('Weight Management', 'Promotes satiety and reduces cravings'),
                InfoBox('Heart Health', 'Lower saturated fat content'),
                InfoBox('Metabolism Boost', 'Enhances metabolic rate'),
              ],
            ),
            SizedBox(height: 20),
            SectionTitle('Best Time to Eat'),
            Text(
              'Lean protein can be consumed at any meal. Incorporate it into breakfast, lunch, dinner, or snacks to maintain balanced nutrition throughout the day.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Who Can Eat It?'),
            Text(
              'Suitable for most individuals, including those on weight loss, muscle-building, or general health improvement diets. Always consider personal dietary needs and consult with a healthcare provider if necessary.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SectionTitle('Other Details'),
            Text(
              'Opt for cooking methods like grilling, baking, or steaming to preserve the lean quality of the protein source. Be mindful of portion sizes and pair with a variety of vegetables and whole grains for a balanced meal.',
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
            color: Colors.blue[800]),
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
