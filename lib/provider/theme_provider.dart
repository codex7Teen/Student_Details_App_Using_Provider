import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  // Boolean variable to track if the dark theme is active
  bool isDarkTheme = false;
  
  // apply theme based on the boolean variable
  ThemeData applyThemeData() {
    return isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

}