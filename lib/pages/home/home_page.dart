import 'package:FitZee/providers/fb_auth_provider.dart';
import 'package:FitZee/services/user_data_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final UserDataSyncService _userDataSyncService = UserDataSyncService();
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _fetchLocalUserData();
  }

  Future<void> _fetchLocalUserData() async {
    // Fetch user data from local storage
    Map<String, dynamic> userData =
        await _userDataSyncService.getLocalUserData();
    await _userDataSyncService.syncPointsToFirestore();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FBAuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        automaticallyImplyLeading: true,
        primary: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: TextStyle(
          color: Colors.deepPurple[900],
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Display Hello message and User Name from Local Storage
              _userData.isNotEmpty
                  ? Text("Hello, ${_userData['firstName'] ?? 'User'}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // color: Colors.blue,
                      ))
                  : const SizedBox.shrink(),

              const SizedBox(height: 10),

              // Menu Title and Options
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Menu",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),

              const SizedBox(height: 10),

              // Grid with Icons and Labels
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 2.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  _buildGridItem(Icons.directions_walk, "Step Count",
                      () => Navigator.pushNamed(context, '/step_count')),
                  _buildGridItem(Icons.fastfood, "Diet",
                      () => Navigator.pushNamed(context, '/diet_home')),
                  _buildGridItem(Icons.fitness_center, "Exercise",
                      () => Navigator.pushNamed(context, '/exercises')),
                  _buildGridItem(Icons.account_circle, "Account",
                      () => Navigator.pushNamed(context, '/account')),
                  _buildGridItem(Icons.leaderboard, "Leader Board",
                      () => Navigator.pushNamed(context, '/leader_board')),
                  _buildGridItem(Icons.chat_bubble_outline, "Chat",
                      () => Navigator.pushNamed(context, '/chat')),
                  _buildGridItem(
                      Icons.data_exploration_rounded,
                      "Past Step Data",
                      () => Navigator.pushNamed(context, '/step_data_page')),
                ],
              ),

              const SizedBox(height: 30),

              // Display local user data with Gauges
              _userData.isNotEmpty
                  ? Column(
                      children: [
                        const Text("Your BMI Data",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),

                        // Display BMI as a gauge
                        SfRadialGauge(
                          axes: [
                            RadialAxis(
                              minimum: 0,
                              maximum: 50,
                              pointers: [
                                NeedlePointer(
                                    value: _calculateBMI()), // Pass BMI value
                              ],
                              ranges: [
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 18.5,
                                    color: Colors.blue),
                                GaugeRange(
                                    startValue: 18.5,
                                    endValue: 24.9,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 24.9,
                                    endValue: 30,
                                    color: Colors.orange),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 50,
                                    color: Colors.red),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Animated BMI category
                        AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: Text(
                            _getBMICategory(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: _getBMIColor()),
                            key: ValueKey<String>(
                                _getBMICategory()), // to trigger animation
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(), // Display loading if no data

              const SizedBox(height: 30),

              // Height and Weight Dashboard Tiles
              if (_userData.isNotEmpty) ...[
                const SizedBox(height: 20),
                _buildDashboardTile("Height", "${_userData['height']} cm"),
                _buildDashboardTile("Weight", "${_userData['weight']} kg"),
              ],

              // Login button if user is null
              if (user == null)
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, "/login"),
                  child: const Text('Login'),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authProvider.signOut();
          Navigator.of(context).pushReplacementNamed("/login");
        },
        tooltip: user == null ? 'Login' : 'Logout',
        child: user == null
            ? const Icon(Icons.login_outlined)
            : const Icon(Icons.logout_outlined),
      ),
    );
  }

  // Helper function to build grid items
  Widget _buildGridItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: const Color.fromARGB(255, 147, 1, 245)),
            const SizedBox(height: 10),
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Helper function to build a dashboard tile
  Widget _buildDashboardTile(String title, String value) {
    return Card(
      color: Colors.blueAccent,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 10),
            Text(value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  // Helper function to calculate BMI (simplified)
  double _calculateBMI() {
    // Make sure to parse height and weight to numeric types
    double height =
        double.tryParse(_userData['height']?.toString() ?? '0') ?? 0;
    double weight =
        double.tryParse(_userData['weight']?.toString() ?? '0') ?? 0;

    if (height > 0 && weight > 0) {
      // BMI = weight (kg) / (height (m) * height (m))
      double bmi = weight /
          (height * height / 10000); // Convert height from cm to meters
      return bmi;
    }
    return 0;
  }

  // Helper function to get BMI category
  String _getBMICategory() {
    double bmi = _calculateBMI();
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

  // Helper function to get BMI color
  Color _getBMIColor() {
    double bmi = _calculateBMI();
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
}
