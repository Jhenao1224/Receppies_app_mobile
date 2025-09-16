import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = "isDarkMode";
  bool get isDark => _isDarkMode;

  ThemeProvider(){
    _loadThemeFromPrefs();
  }

  _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool(_themeKey) ?? false;
      notifyListeners();
    } catch (e) {
      _isDarkMode = false;
    }
  }

  _saveThemeToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(_themeKey, _isDarkMode);
    } catch (e) {
      // Handle error if needed
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    // print('Theme changed to: $_isDarkMode');
    _saveThemeToPrefs();
    notifyListeners();
  }

}