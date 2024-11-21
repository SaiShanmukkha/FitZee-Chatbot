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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Account",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Text("Theme Switch"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Switch(
              value: Provider.of<ThemeProvider>(context).isDarkTheme,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(value),
              activeColor: const Color.fromARGB(255, 14, 64, 104),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Personal Information Card
            _infoCard(
              context,
              title: "Personal Information",
              data: [
                {
                  'icon': Icons.person,
                  'label': 'Name',
                  'value':
                      "${_userData?['firstName'] ?? ""} ${_userData?['lastName'] ?? ""}"
                },
                {
                  'icon': Icons.wc,
                  'label': 'Gender',
                  'value': _userData?['gender'] ?? "N/A"
                },
                {
                  'icon': Icons.cake,
                  'label': 'DOB',
                  'value': _userData?['dateOfBirth'] ?? "N/A"
                },
              ],
            ),

            // Goal Information Card
            _infoCard(
              context,
              title: "Goal Information",
              data: [
                {
                  'icon': Icons.fitness_center,
                  'label': 'Weight Goal',
                  'value': _userData?['weightGoal'] ?? "N/A"
                },
                {
                  'icon': Icons.star,
                  'label': 'Total Points',
                  'value': _userData?['totalPoints']?.toString() ?? "N/A"
                },
              ],
            ),

            // Account Information Card
            _infoCard(
              context,
              title: "Account Information",
              data: [
                {
                  'icon': Icons.email,
                  'label': 'Email',
                  'value': _user?.email ?? "N/A"
                },
                {
                  'icon': Icons.account_circle,
                  'label': 'User ID',
                  'value': _userData?['userID'] ?? "N/A"
                },
              ],
            ),

            // Update Progress Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/user_data');
                },
                icon: const Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                label: const Text(
                  "Update Data",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 24, 64),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context,
      {required String title, required List<Map<String, dynamic>> data}) {
    // Change String to dynamic here
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              ...data.map((item) => ListTile(
                    leading: Icon(item['icon'] as IconData), // Cast to IconData
                    title: Text(item['label'] as String),
                    subtitle: Text(item['value'] as String),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
