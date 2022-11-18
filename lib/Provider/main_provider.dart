import 'package:flutter/material.dart';
import 'dark_theme_preferences.dart';

class DarkThemeIcon extends ChangeNotifier {
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();
  bool _darkTheme = false; 
  bool get darkTheme1 => _darkTheme;


  void toogleTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }

  set darkTheme1(bool value) {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}