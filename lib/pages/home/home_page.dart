import 'dart:async';
import 'package:FitZee/components/bmi_data.dart';
import 'package:FitZee/constants/health_tips.dart';
import 'package:FitZee/providers/fb_auth_provider.dart';
import 'package:FitZee/services/user_data_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final UserDataSyncService _userDataSyncService = UserDataSyncService();
  Map<String, dynamic> _userData = {};
  String currentTip = "";

  @override
  void initState() {
    super.initState();
    _fetchLocalUserData();
    _startHealthTipsTimer();
  }

  Future<void> _fetchLocalUserData() async {
    Map<String, dynamic> userData =
        await _userDataSyncService.getLocalUserData();
    await _userDataSyncService.syncPointsToFirestore();
    setState(() {
      _userData = userData;
    });
  }

  void _startHealthTipsTimer() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        currentTip = (healthTips..shuffle()).first;
      });
    });
    currentTip = (healthTips..shuffle()).first;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FBAuthProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CurvedAppBarClipper(),
                child: Container(
                  height: 200,
                  color: Colors.deepPurple,
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pushNamed(context, '/account');
                          },
                          tooltip: 'Account',
                        ),
                        TextButton.icon(
                          onPressed: () {
                            authProvider.signOut();
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: const Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 131, 101, 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 130,
                left: 130,
                child: _userData.isNotEmpty
                    ? Text(
                        "Hello, ${_userData['firstName'] ?? 'User'}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Menu",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        _buildGridItem(Icons.directions_walk, "Step Count",
                            () => Navigator.pushNamed(context, '/step_count')),
                        _buildGridItem(
                            Icons.leaderboard,
                            "Leader Board",
                            () =>
                                Navigator.pushNamed(context, '/leader_board')),
                        _buildGridItem(Icons.chat, "Fitzee Bot",
                            () => Navigator.pushNamed(context, '/chat')),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _userData.isNotEmpty
                        ? BMIWidget(
                            height: _userData['height'],
                            weight: _userData['weight'])
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.0,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        _buildGridItem(Icons.fitness_center, "Exercise",
                            () => Navigator.pushNamed(context, '/exercises')),
                        _buildGridItem(
                            Icons.data_object,
                            "Exercise Log",
                            () =>
                                Navigator.pushNamed(context, '/exercise_log')),
                        _buildGridItem(Icons.fastfood, "Diet",
                            () => Navigator.pushNamed(context, '/diet_home')),
                        _buildGridItem(
                            Icons.data_exploration_rounded,
                            "Past Step Data",
                            () => Navigator.pushNamed(
                                context, '/step_data_page')),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildHealthTipsBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildHealthTipsBox() {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Container(
        key: ValueKey<String>(currentTip),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Row(
          children: [
            const Icon(Icons.health_and_safety, color: Colors.green, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                currentTip,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
