import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class theme with ChangeNotifier {
  ThemeData _themeData;
  theme(this._themeData);

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', themeData.brightness == Brightness.dark);
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? true;
    _themeData = isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  Color get bottomNavSelectedItemColor =>
      _themeData.brightness == Brightness.dark ? Colors.blue : Colors.blue;

  Color get bottomNavUnselectedItemColor =>
      _themeData.brightness == Brightness.dark ? Colors.white70 : Colors.black54;
}
