import 'package:FitZee/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({super.key});

  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userData = userDoc.data();
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Center(child: Text("No user logged in"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme toggle button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Dark Theme',
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color, // Ensure text is visible in both modes
                        ),
                      ),
                      Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkTheme,
                        onChanged: (value) =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme(value),
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Display user information
                  Text(
                    'Personal Information:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Name: ${_userData?['firstName'] ?? "N/A"} ${_userData?['lastName'] ?? "N/A"}'),
                  Text('Gender: ${_userData?['gender'] ?? "N/A"}'),
                  Text('Date of Birth: ${_userData?['dateOfBirth'] ?? "N/A"}'),
                  const SizedBox(height: 16),
                  Text(
                    'Goal Information:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Weight Goal: ${_userData?['weightGoal'] ?? "N/A"}'),
                  Text('Total Points: ${_userData?['totalPoints'] ?? "N/A"}'),
                  const SizedBox(height: 16),
                  Text(
                    'Account Information:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Email: ${_user?.email ?? "N/A"}'),
                  Text('User ID: ${_userData?['userID'] ?? "N/A"}'),
                ],
              ),
            ),
    );
  }
}
