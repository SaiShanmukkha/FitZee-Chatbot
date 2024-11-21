import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIWidget extends StatelessWidget {
  final String height;
  final String weight;

  const BMIWidget({super.key, required this.height, required this.weight});

  double _calculateBMI() {
    double height = double.tryParse(this.height.toString()) ?? 0;
    double weight = double.tryParse(this.weight.toString()) ?? 0;

    if (height > 0 && weight > 0) {
      double bmi = weight / (height * height / 10000);
      return bmi;
    }
    return 0;
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25 && bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = _calculateBMI();
    String category = _getBMICategory(bmi);
    Color categoryColor = _getBMIColor(bmi);

    return Column(
      children: [
        const Text(
          "Your BMI Data",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInfoBox(
              title: "Weight",
              value: "${weight} kg",
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 16),
            _buildInfoBox(
              title: "Height",
              value: "${height} cm",
              color: Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 2000,
          axes: [
            RadialAxis(
              minimum: 0,
              maximum: 50,
              pointers: [
                NeedlePointer(value: bmi),
              ],
              ranges: [
                GaugeRange(startValue: 0, endValue: 18.5, color: Colors.blue),
                GaugeRange(
                    startValue: 18.5, endValue: 24.9, color: Colors.green),
                GaugeRange(
                    startValue: 24.9, endValue: 30, color: Colors.orange),
                GaugeRange(startValue: 30, endValue: 50, color: Colors.red),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Text(
                    "BMI: ${bmi.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  positionFactor: 0.8,
                  angle: 90,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: categoryColor,
            ),
            key: ValueKey<String>(category),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(
      {required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
