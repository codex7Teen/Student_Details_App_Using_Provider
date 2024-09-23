import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  bool isDarkTheme = false;

  ThemeData get themeData => isDarkTheme ? ThemeData.dark() : ThemeData.light();

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

}