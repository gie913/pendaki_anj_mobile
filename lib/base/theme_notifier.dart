
import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/palette.dart';
import 'package:pendaki_champion/manager/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    fontFamily: "DIN Pro",
    primarySwatch: Colors.orange,
    primaryColor: Color(0xFF212121),
    brightness: Brightness.dark,
    dividerTheme: DividerThemeData(color: Colors.grey),
    backgroundColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.transparent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.primaryColorProd),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    dividerColor: Colors.black,
  );

  final lightTheme = ThemeData(
    fontFamily: "DIN Pro",
    primarySwatch: Colors.orange,
    primaryColor: Palette.greenColor,
    primaryColorDark: Palette.greenColorDark,
    primaryColorLight: Palette.greenColorLight,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        color: Palette.primaryColorProd),
    indicatorColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    cardColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Palette.greenColor),
      ),
    ),
    backgroundColor: Palette.greenColorLight,
  );

  ThemeData? _themeData;

  bool? _status;

  bool? get status => _status;

  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    _status = false;
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
        _status = false;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
        _status = true;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    _status = true;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    _status = false;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
