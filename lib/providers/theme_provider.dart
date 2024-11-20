import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkTheme = isDark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }
}
