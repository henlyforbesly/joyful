import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  static const themestatus = "themestatus";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themestatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          themestatus,
        ) ??
        false;
  }
}
