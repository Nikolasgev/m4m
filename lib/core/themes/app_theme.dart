import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF8E97FD),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8E97FD),
      secondary: Color(0xFFA6C1EE),
      surface: Color(0xFFF6F1FB),
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F1FB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8E97FD),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8E97FD),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF8E97FD),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF8E97FD),
      secondary: Color(0xFFA6C1EE),
      surface: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8E97FD),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8E97FD),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
