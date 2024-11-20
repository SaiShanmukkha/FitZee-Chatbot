import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FitZee/models/user_level.dart';
import 'package:FitZee/services/user_progress_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late Future<List<UserProgress>> _leaderboardData;
  late Future<List<dynamic>> _topUsers;
  late Future<Map<BadgeType, int>> _badgeTotals;
  int totalPoints = 0;
  int userLevel = 0;
  double progressToNextLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _topUsers = _fetchTopUsers();
    _leaderboardData = UserProgressService().getLeaderboardData();
    _badgeTotals = UserProgressService().getBadgeTotals();
    _loadPointsAndCalculateLevel();
  }

  Future<List<dynamic>> _fetchTopUsers() async {
    final response = await http.get(Uri.parse('https://gettopusers-ighj26hgva-uc.a.run.app'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load top users');
    }
  }

  Future<void> _loadPointsAndCalculateLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPoints = prefs.getInt('totalPoints') ?? 0;
      userLevel = totalPoints ~/ 30;
      progressToNextLevel = (totalPoints % 30) / 30;
    });
  }

  Widget _getBadgeImage(BadgeType badge) {
    String imagePath;
    switch (badge) {
      case BadgeType.gold:
        imagePath = 'assets/images/gold-badge.png';
        break;
      case BadgeType.silver:
        imagePath = 'assets/images/silver-badge.png';
        break;
      case BadgeType.bronze:
        imagePath = 'assets/images/bronze-badge.png';
        break;
      default:
        return Icon(Icons.badge, color: Colors.grey, size: 30);
    }
    return Image.asset(imagePath, width: 30, height: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.deepPurple[900],
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Map<BadgeType, int>>(
              future: _badgeTotals,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error loading data"));
                } else if (!snapshot.hasData) {
                  return Center(child: Text("No data available"));
                } else {
                  final badgeTotals = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[100],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Total Points: $totalPoints',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Level: $userLevel',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progressToNextLevel,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Next Level in ${30 - (totalPoints % 30)} points',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'My Badges',
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset('assets/images/bronze-badge.png',
                                    width: 30, height: 30),
                                SizedBox(height: 4),
                                Text(
                                    'Bronze: ${badgeTotals[BadgeType.bronze] ?? 0}'),
                                SizedBox(height: 4),
                                Text('10 points',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/silver-badge.png',
                                    width: 30, height: 30),
                                SizedBox(height: 4),
                                Text(
                                    'Silver: ${badgeTotals[BadgeType.silver] ?? 0}'),
                                SizedBox(height: 4),
                                Text('15 points',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/gold-badge.png',
                                    width: 30, height: 30),
                                SizedBox(height: 4),
                                Text(
                                    'Gold: ${badgeTotals[BadgeType.gold] ?? 0}'),
                                SizedBox(height: 4),
                                Text('30 points',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Top 5 Users',
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder<List<dynamic>>(
                          future: _topUsers,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error loading data"));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(child: Text("No data available"));
                            } else {
                              final topUsers = snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: topUsers.length,
                                itemBuilder: (context, index) {
                                  final user = topUsers[index];
                                  final userPoints = user['points'];
                                  final userLevel = userPoints ~/ 30;
                                  return ListTile(
                                    leading: Icon(
                                      Icons.emoji_events,
                                      color: Colors.amber,
                                      size: 30,
                                    ),
                                    title: Text(
                                      '${user['firstName']} ${user['lastName']}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Points: $userPoints, Level: $userLevel',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Text(
                        'My Daily Progress',
                        style: TextStyle(
                            color: Colors.deepPurple[900],
                            fontWeight: FontWeight.w900,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 300, // Adjust height as needed
                        child: FutureBuilder<List<UserProgress>>(
                          future: _leaderboardData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error loading data"));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(child: Text("No data available"));
                            } else {
                              final leaderboard = snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: leaderboard.length,
                                itemBuilder: (context, index) {
                                  final userProgress = leaderboard[index];
                                  return ListTile(
                                    leading: _getBadgeImage(userProgress.badge),
                                    title: Text(
                                      'Date: ${userProgress.date}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Steps: ${userProgress.stepCount}'),
                                            Text(
                                                'Exercise: ${userProgress.exerciseDurationMinutes} mins'),
                                          ],
                                        ),
                                        Text(
                                          '${userProgress.badgeSource}',
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
