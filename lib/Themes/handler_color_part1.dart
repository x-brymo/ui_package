import 'package:flutter/material.dart';

MaterialColor buildMaterialColor(Color color) {
  Map<int, Color> colorSwatch = {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color.withOpacity(1),
  };
  return MaterialColor(color.value, colorSwatch);
}


MaterialColor getMaterialColor() {
  int colorValue = 0xFFC9F5FC;
  Color color = Color(colorValue);
  Map<int, Color> shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
      .asMap()
      .map((key, value) => MapEntry(value, color.withOpacity(1 - (1 - (key + 1) / 10))));

  return MaterialColor(colorValue, shades);
}

extension ToMaterialColor on Color {
  MaterialColor get asMaterialColor {
    Map<int, Color> shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
        .asMap()
        .map((key, value) => MapEntry(value, withOpacity(1 - (1 - (key + 1) / 10))));

    return MaterialColor(value, shades);
  }
}
//extension ToMaterialColor on Color...
//primarySwatch: Color(0xFFC9F5FC).asMaterialColor

MaterialColor buildMaterialColors(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
class Decor {
  static const Color kColor = Color(0xff13CB4E);
}