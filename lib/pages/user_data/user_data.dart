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
    _fetchExistingUserData(); // Fetch existing user data and pre-fill fields
  }

  Future<void> _fetchExistingUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          // Pre-fill existing data into controllers
          final data = doc.data()!;
          setState(() {
            firstNameController.text = data['firstName'] ?? '';
            lastNameController.text = data['lastName'] ?? '';
            dobController.text = data['dateOfBirth'] ?? '';
            heightController.text = data['height'] ?? '150'; // Default to 150
            weightController.text = data['weight'] ?? '';
            weightGoal = data['weightGoal'] ?? 'Gain';
            gender = data['gender'] ?? 'Male';
            heightValue = double.tryParse(heightController.text) ?? 150;
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> saveUserData() async {
    if (_validateInputs()) {
      final user = _auth.currentUser;

      if (user != null) {
        try {
          // Prepare user data
          Map<String, dynamic> userData = {
            'userID': user.uid,
            'firstName': firstNameController.text.trim(),
            'lastName': lastNameController.text.trim(),
            'dateOfBirth': dobController.text.trim(),
            'height': heightController.text.trim(),
            'weight': weightController.text.trim(),
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
    } else {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  bool _validateInputs() {
    // Ensure no fields are empty
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        weightController.text.isNotEmpty;
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

  Widget buildStepCard(
      String label,
      TextEditingController? controller, // Make this optional
      IconData icon,
      Color color,
      String hintText,
      Widget? field) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
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
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              field ??
                  TextField(
                    controller: controller, // Safely assign nullable controller
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: moveToNextStep,
                child:
                    const Text('Next', style: TextStyle(color: Colors.white)),
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
      appBar: AppBar(title: const Text('Complete Your Profile')),
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
                        hintStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white24,
                      ),
                      style: const TextStyle(color: Colors.white),
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
                      heightController.text = "${heightValue.round()}";
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
                null, // No controller needed
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
                    const Text('Male', style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text('Female', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            if (currentStep == 6)
              buildStepCard(
                "Weight Goal",
                null, // No controller needed
                Icons.assignment_turned_in,
                const Color.fromARGB(255, 79, 73, 6),
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
                    const Text('Gain', style: TextStyle(color: Colors.white)),
                    Radio<String>(
                      value: 'Lose',
                      groupValue: weightGoal,
                      onChanged: (value) {
                        setState(() {
                          weightGoal = value!;
                        });
                      },
                    ),
                    const Text('Lose', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            if (currentStep == 7)
              ElevatedButton(
                onPressed: saveUserData,
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
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
