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
  String userTier = 'Bronze'; // Default Tier
  double progressToNextTier = 0.0;

  @override
  void initState() {
    super.initState();
    _topUsers = _fetchTopUsers();
    _leaderboardData = UserProgressService().getLeaderboardData();
    _badgeTotals = UserProgressService().getBadgeTotals();
    _loadPointsAndCalculateTier();
  }

  Future<List<dynamic>> _fetchTopUsers() async {
    final response = await http
        .get(Uri.parse('https://gettopusers-ighj26hgva-uc.a.run.app'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load top users');
    }
  }

  Future<void> _loadPointsAndCalculateTier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final oldTier = userTier;
    setState(() {
      totalPoints = prefs.getInt('totalPoints') ?? 0;
      userTier = _calculateTier(totalPoints);
      progressToNextTier = _calculateProgressToNextTier(totalPoints);
    });

    if (oldTier != userTier) {
      _showTierChangeDialog(oldTier, userTier);
    }
  }

  String _calculateTier(int points) {
    const tiers = [
      'Bronze',
      'Silver',
      'Gold',
      'Platinum',
      'Diamond',
      'Master',
      'GrandMaster',
      'Pro',
    ];
    int tierIndex = points ~/ 90; // Each tier spans 90 points
    if (tierIndex >= tiers.length) tierIndex = tiers.length - 1; // Cap at "Pro"
    return tiers[tierIndex];
  }

  double _calculateProgressToNextTier(int points) {
    return (points % 90) / 90;
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

  void _showTierChangeDialog(String oldTier, String newTier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations! 🎉'),
        content: Text(
          'You have progressed from $oldTier tier to $newTier tier. Keep it up!',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Okay',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
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
                              'Tier: $userTier',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progressToNextTier,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Next Tier in ${90 - (totalPoints % 90)} points',
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
                                Text('1 points',
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
                                Text('2 points',
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
                                Text('3 points',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Top Users',
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 16),
                      FutureBuilder<List<dynamic>>(
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
                                return ListTile(
                                  leading: const Icon(
                                    Icons.emoji_events,
                                    color: Colors.amber,
                                    size: 30,
                                  ),
                                  title: Text(
                                    '${user['firstName']} ${user['lastName']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Points: $userPoints, Tier: ${_calculateTier(userPoints)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'My Daily Progress',
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 16),
                      FutureBuilder<List<UserProgress>>(
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
                              physics: NeverScrollableScrollPhysics(),
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
