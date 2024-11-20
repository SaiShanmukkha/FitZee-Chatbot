import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietHomePage extends StatefulWidget {
  @override
  _DietHomePageState createState() => _DietHomePageState();
}

class _DietHomePageState extends State<DietHomePage> {
  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Guacamole',
      'category': 'Weight Gain',
      'route': '/diet/guacamole',
      'image': 'assets/images/guacamole.jpg',
    },
    {
      'name': 'Nuts and Nut Butters',
      'category': 'Weight Gain',
      'route': '/diet/nutbutter',
      'image': 'assets/images/nuts.jpg',
    },
    {
      'name': 'Whole-Grain Bread',
      'category': 'Weight Gain',
      'route': '/diet/wholegrain',
      'image': 'assets/images/whole_grain_bread.jpg',
    },
    {
      'name': 'Cheese',
      'category': 'Weight Gain',
      'route': '/diet/cheese',
      'image': 'assets/images/cheese.jpg',
    },
    {
      'name': 'Red Meat',
      'category': 'Weight Gain',
      'route': '/diet/redmeat',
      'image': 'assets/images/lean_red_meat.jpg',
    },
    {
      'name': 'Leafy Greens',
      'category': 'Weight Loss',
      'route': '/diet/leafygreens',
      'image': 'assets/images/leafy_greens.jpg',
    },
    {
      'name': 'Lean Protein (e.g., Chicken Breast)',
      'category': 'Weight Loss',
      'route': '/diet/leanprotein',
      'image': 'assets/images/lean_protein.jpg',
    },
    {
      'name': 'Berries',
      'category': 'Weight Loss',
      'route': '/diet/berries',
      'image': 'assets/images/berries.jpg',
    },
    {
      'name': 'Whole Eggs',
      'category': 'Weight Loss',
      'route': '/diet/wholeeggs',
      'image': 'assets/images/whole_eggs.png',
    },
    {
      'name': 'Greek Yogurt',
      'category': 'Weight Loss',
      'route': '/diet/greekyogurt',
      'image': 'assets/images/greek_yogurt.jpg',
    },
  ];

  String weight = '';
  String weightGoal = '';

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      weight = prefs.getString('weight') ?? 'Unknown';
      weightGoal = prefs.getString('weightGoal') ?? 'Unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            floating: true,
            title: Text(
              "Diet Foods",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            pinned: true,
            backgroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _infoBox('Current Weight', weight, Colors.white,
                            Colors.teal[700]!),
                        _infoBox('Target Goal', weightGoal, Colors.white,
                            Colors.teal[700]!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final food = foods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        food['route'],
                        arguments: food,
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0),
                              ),
                              child: Image.asset(
                                food['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  food['category'],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: foods.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
