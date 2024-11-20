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
    return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Count Data"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : stepDataList.isEmpty
              ? Center(child: Text("No step data available."))
              : ListView.builder(
                  itemCount: stepDataList.length,
                  itemBuilder: (context, index) {
                    final stepEntry = stepDataList[index];
                    return ListTile(
                      title: Text(
                        "Date: ${_formatDateTime(stepEntry.date)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Step Count: ${stepEntry.stepCount}",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
    );
  }
}
