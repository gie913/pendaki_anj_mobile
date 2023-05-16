
import 'package:flutter/material.dart';

class Palette {
  static Color primaryColorProd = Color(0xff016873);
  static Color redColorDark = Color(0xff9b0000);
  static Color redColorLight = Color(0xffb71c1c);
  static Color yellowColorDark = Color(0xfff9a825);

  static Color greenColor = Color(0xff31a020);
  static Color greenColorLight = Color(0xff6ad252);
  static Color greenColorDark = Color(0xff007000);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

}