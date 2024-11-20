import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FitZee/services/user_progress_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserDataSyncService() {
    _setupUserListener(); // Start listening to Firestore data on init
  }

  // Fetch user data from Firestore and store it locally
  Future<void> fetchAndStoreUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        // Store fetched data locally
        await _saveToLocalStorage(doc.data());
      }
    }
  }

  // Set up a listener to keep local data in sync with Firestore changes
  void _setupUserListener() {
    final user = _auth.currentUser;

    if (user != null) {
      _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((snapshot) async {
        if (snapshot.exists) {
          await _saveToLocalStorage(snapshot.data());
        }
      });
    }
  }

  // Save data locally using SharedPreferences
  Future<void> _saveToLocalStorage(Map<String, dynamic>? data) async {
    if (data != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Store each field in SharedPreferences
      await prefs.setString('userID', data['userID'] ?? '');
      await prefs.setString('dateOfBirth', data['dateOfBirth'] ?? '');
      await prefs.setString('firstName', data['firstName'] ?? '');
      await prefs.setString('lastName', data['lastName'] ?? '');
      await prefs.setString('gender', data['gender'] ?? '');
      await prefs.setString('height', data['height'] ?? '');
      await prefs.setString('weight', data['weight'] ?? '');
      await prefs.setString('weightGoal', data['weightGoal'] ?? '');
      await prefs.setBool(
          'tookInitialValue', data['tookInitialValue'] ?? false);

      // Save points to local storage
      if (data.containsKey('totalPoints')) {
        await prefs.setInt('totalPoints', data['totalPoints'] ?? 0);
      }
    }
  }

  // Retrieve data from local storage
  Future<Map<String, dynamic>> getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'userID': prefs.getString('userID') ?? '',
      'dateOfBirth': prefs.getString('dateOfBirth') ?? '',
      'firstName': prefs.getString('firstName') ?? '',
      'lastName': prefs.getString('lastName') ?? '',
      'gender': prefs.getString('gender') ?? '',
      'height': prefs.getString('height') ?? '',
      'weight': prefs.getString('weight') ?? '',
      'weightGoal': prefs.getString('weightGoal') ?? '',
      'tookInitialValue': prefs.getBool('tookInitialValue') ?? false,
      'totalPoints': prefs.getInt('totalPoints') ?? 0,
    };
  }

  // Sync points to Firestore
  Future<void> syncPointsToFirestore() async {
    final user = _auth.currentUser;
    if (user != null) {
      final totalPoints = await UserProgressService().calculateTotalPoints();

      await _firestore.collection('users').doc(user.uid).update({
        'totalPoints': totalPoints,
      });
    }
  }
}
