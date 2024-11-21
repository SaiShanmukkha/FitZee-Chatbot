import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class HealthTipsWrapper extends StatelessWidget {
  final Widget child;

  const HealthTipsWrapper({super.key, required this.child});

  Future<String> _getRandomHealthTip(BuildContext context) async {
    String tipsJson = await DefaultAssetBundle.of(context)
        .loadString('assets/daily_health_tips.json');
    List<String> tips = List<String>.from(json.decode(tipsJson));
    return tips[Random().nextInt(tips.length)];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getRandomHealthTip(context),
      builder: (context, snapshot) {
        String tip = snapshot.data ?? "Stay healthy!";
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                "Daily Health Tip: $tip",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}
