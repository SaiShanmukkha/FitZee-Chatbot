import 'package:flutter/material.dart';
import 'package:FitZee/models/step_data.dart';
import 'package:FitZee/services/stepcount_database_service.dart';

class StepDataPage extends StatefulWidget {
  @override
  _StepDataPageState createState() => _StepDataPageState();
}

class _StepDataPageState extends State<StepDataPage> {
  List<StepCountEntry> stepDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStepData();
  }

  Future<void> _loadStepData() async {
    try {
      // Fetch step data from the database
      final data = await StepcountDatabaseService().getAllStepData();
      setState(() {
        stepDataList = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading step data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatDateTime(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Count Data"),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : stepDataList.isEmpty
              ? Center(
                  child: Text(
                    "No step data available.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: stepDataList.length,
                    itemBuilder: (context, index) {
                      final stepEntry = stepDataList[index];
                      return _buildStepCard(stepEntry);
                    },
                  ),
                ),
    );
  }

  Widget _buildStepCard(StepCountEntry stepEntry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Date icon or graphic
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today,
                color: Colors.deepPurple,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Date and step data
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDateTime(stepEntry.date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Steps: ${stepEntry.stepCount}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Icon for more actions or visualization
            Icon(
              Icons.directions_walk,
              color: Colors.deepPurple,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
