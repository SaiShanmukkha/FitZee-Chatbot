import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FitZee/services/user_data_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class UserDataCollectionPage extends StatefulWidget {
  @override
  _UserDataCollectionPageState createState() => _UserDataCollectionPageState();
}

class _UserDataCollectionPageState extends State<UserDataCollectionPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController weightGoalController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String weightGoal = 'Gain'; // Default value for weight goal
  String gender = 'Male'; // Default gender value

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserDataSyncService _userDataSyncService;

  int currentStep = 0;

  double heightValue = 150; // Default height value (150 cm)

  @override
  void initState() {
    super.initState();
    _userDataSyncService = UserDataSyncService();
    checkUserData();
  }

  Future<void> checkUserData() async {
    final user = _auth.currentUser;

    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists && doc['tookInitialValue'] == true) {
        await _userDataSyncService.fetchAndStoreUserData();
        Navigator.pushReplacementNamed(context, "/home");
      }
    }
  }

  Future<void> saveUserData() async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        // Prepare user data
        Map<String, dynamic> userData = {
          'userID': user.uid,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'dateOfBirth': dobController.text,
          'height': heightController.text,
          'weight': weightController.text,
          'gender': gender,
          'weightGoal': weightGoal,
          'tookInitialValue': true,
        };

        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set(userData);

        // Sync data locally after saving it to Firestore
        await _userDataSyncService.fetchAndStoreUserData();

        // Navigate to Home Page after saving data
        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        print('Error saving user data: $e');
      }
    }
  }

  void moveToNextStep() {
    setState(() {
      currentStep++;
    });
  }

  void moveToPreviousStep() {
    setState(() {
      currentStep--;
    });
  }

  Widget buildStepCard(String label, TextEditingController controller,
      IconData icon, Color color, String hintText, Widget? field) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 20),
              Text(label,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              field ??
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: moveToNextStep,
                child: Text('Next', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (currentStep == 0)
              buildStepCard("First Name", firstNameController, Icons.person,
                  Colors.deepOrange, "Enter your first name", null),
            if (currentStep == 1)
              buildStepCard("Last Name", lastNameController, Icons.person,
                  Colors.green, "Enter your last name", null),
            if (currentStep == 2)
              buildStepCard(
                "Date of Birth",
                dobController,
                Icons.calendar_today,
                Colors.blue,
                "Select your date of birth",
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dobController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        hintText: "YYYY-MM-DD",
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white24,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (currentStep == 3)
              buildStepCard(
                "Height (cm)",
                heightController,
                Icons.height,
                Colors.purple,
                "Select your height",
                Slider(
                  value: heightValue,
                  min: 100,
                  max: 250,
                  divisions: 150,
                  label: "${heightValue.round()} cm",
                  onChanged: (double newValue) {
                    setState(() {
                      heightValue = newValue;
                      heightController.text =
                          "${heightValue.round()}"; // Update the text field value
                    });
                  },
                ),
              ),
            if (currentStep == 4)
              buildStepCard("Weight (kg)", weightController,
                  Icons.fitness_center, Colors.red, "Enter your weight", null),
            if (currentStep == 5)
              buildStepCard(
                "Gender",
                genderController,
                Icons.wc,
                Colors.teal,
                "Select your gender",
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Male', style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Female', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            if (currentStep == 6)
              buildStepCard(
                "Weight Goal",
                weightGoalController,
                Icons.assignment_turned_in,
                Colors.yellow,
                "Select weight goal",
                Row(
                  children: [
                    Radio<String>(
                      value: 'Gain',
                      groupValue: weightGoal,
                      onChanged: (value) {
                        setState(() {
                          weightGoal = value!;
                        });
                      },
                    ),
                    Text('Gain', style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'Lose',
                      groupValue: weightGoal,
                      onChanged: (value) {
                        setState(() {
                          weightGoal = value!;
                        });
                      },
                    ),
                    Text('Lose', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            if (currentStep == 7)
              ElevatedButton(
                onPressed: saveUserData,
                child: Text('Save', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
