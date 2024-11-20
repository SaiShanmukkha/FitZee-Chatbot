import 'package:flutter/material.dart';

class DietHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> foods = [
    {'name': 'Nuts and Nut Butters', 'category': 'Weight Gain'},
    {'name': 'Whole-Grain Bread', 'category': 'Weight Gain'},
    {'name': 'Avocado', 'category': 'Weight Gain'},
    {'name': 'Cheese', 'category': 'Weight Gain'},
    {'name': 'Red Meat', 'category': 'Weight Gain'},
    {'name': 'Leafy Greens', 'category': 'Weight Loss'},
    {'name': 'Lean Protein (e.g., Chicken Breast)', 'category': 'Weight Loss'},
    {'name': 'Berries', 'category': 'Weight Loss'},
    {'name': 'Whole Eggs', 'category': 'Weight Loss'},
    {'name': 'Greek Yogurt', 'category': 'Weight Loss'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Foods'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(foods[index]['category'] == 'Weight Gain'
                ? Icons.add
                : Icons.remove),
            title: Text(foods[index]['name']),
            subtitle: Text(foods[index]['category']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/food_detail',
                arguments: foods[index],
              );
            },
          );
        },
      ),
    );
  }
}
