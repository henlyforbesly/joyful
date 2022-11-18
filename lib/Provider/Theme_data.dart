import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: isDarkTheme
          ? const Color.fromARGB(255, 104, 94, 4)
          : Colors.grey.shade300,
      scaffoldBackgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xffffbf00) : Colors.white,
      canvasColor: isDarkTheme ? Colors.grey.shade800 : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    );
  }
}
