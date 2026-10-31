import 'package:flutter/material.dart';

class Design {
  static Color get primary => Color(0xFFFF5F00);
  //static Color get secondary => Color(0xFFFFCB84);
  static Color get surface => Color(0xFFFFEED2);
  static Color get surface2 => Color(0xFFF6F6F6);
  static Color get textColor => Color.fromARGB(255, 31, 30, 30);
}



final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Design.primary,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Design.surface,
    foregroundColor: Design.textColor,
    iconTheme: IconThemeData(color: Design.primary),
    titleTextStyle: TextStyle(
      color: Design.textColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Design.textColor),
    bodyMedium: TextStyle(color: Colors.grey[800]),
  ),
  colorScheme: ColorScheme.light(
    primary: Design.primary,
    surface: Design.surface,
    background: Colors.white,
    onPrimary: Colors.white,
    onSurface: Design.textColor,
  ),
  iconTheme: IconThemeData(color: Design.primary),
  buttonTheme: ButtonThemeData(
    buttonColor: Design.primary,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Design.primary,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Design.surface,
    iconTheme: IconThemeData(color: Design.primary),
    titleTextStyle: TextStyle(
      color: Design.surface,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Design.surface),
    bodyMedium: TextStyle(color: Design.surface2),
  ),
  colorScheme: ColorScheme.dark(
    primary: Design.primary,
    surface: Colors.grey[850]!,
    background: Colors.black,
    onPrimary: Colors.black,
    onSurface: Design.surface,
  ),
  iconTheme: IconThemeData(color: Design.primary),
  buttonTheme: ButtonThemeData(
    buttonColor: Design.primary,
    textTheme: ButtonTextTheme.primary,
  ),
);
