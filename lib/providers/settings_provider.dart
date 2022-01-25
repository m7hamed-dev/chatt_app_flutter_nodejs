import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool isDark = false;
  //
  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
