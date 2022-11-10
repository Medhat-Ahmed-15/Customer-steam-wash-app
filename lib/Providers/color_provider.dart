import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider with ChangeNotifier {
  Color backgroundColor = Colors.white;
  Color backgroundDialogColor =
      const Color.fromRGBO(44, 62, 80, 1).withOpacity(1);
  Color textColor = const Color.fromRGBO(23, 32, 42, 1);
  Color containerBackGroundColor = Colors.grey[200];

  void switchToDarkThemeMode() {
    backgroundColor = const Color.fromRGBO(23, 32, 42, 1);
    backgroundDialogColor = const Color.fromRGBO(44, 62, 80, 1).withOpacity(1);
    containerBackGroundColor = Colors.grey[200];
    textColor = Colors.white;
    notifyListeners();
  }

  void switchToLightThemeMode() {
    backgroundColor = Colors.white;
    backgroundDialogColor = const Color.fromRGBO(243, 244, 246, 1);
    containerBackGroundColor = Colors.grey[200];
    textColor = const Color.fromRGBO(23, 32, 42, 1);
    notifyListeners();
  }

  Future<void> checkThemeMethodInThisScreen() async {
    final tunnelToStorage = await SharedPreferences.getInstance();

    if (!tunnelToStorage.containsKey('switchStatus')) {
      switchToLightThemeMode();
      return;
    }

    final extractedUserData =
        json.decode(tunnelToStorage.getString('switchStatus'))
            as Map<String, Object>;

    if (extractedUserData['status'] == true) {
      switchToDarkThemeMode();
    } else {
      switchToLightThemeMode();
    }
  }
}
