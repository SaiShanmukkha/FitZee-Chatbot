import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FBAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  User? _user;

  User? get user => _user;

  FBAuthProvider() {
    _auth.authStateChanges().listen((User? user) async {
      _user = user;
      if (user != null) {
        // Save login status securely
        await _secureStorage.write(key: 'isLoggedIn', value: 'true');
      } else {
        // Clear login status
        await _secureStorage.delete(key: 'isLoggedIn');
      }
      notifyListeners();
    });
  }

  Future<bool> isUserLoggedIn() async {
    String? isLoggedIn = await _secureStorage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return {"status": true, "message": "Login Successful"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": e.message, "code": e.code};
    }
  }

  Future<Map<String, dynamic>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return {"status": true, "message": "Account Creation Successful"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": e.message};
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    // Clear secure storage
    await _secureStorage.deleteAll();
    notifyListeners();
  }
}
