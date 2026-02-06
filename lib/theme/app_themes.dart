import 'package:flutter/material.dart';

enum AppTheme { light, dark, pastel }

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    primaryColor: const Color(0xFF2563EB),
    cardColor: Colors.white,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    primaryColor: const Color(0xFF38BDF8),
    cardColor: const Color(0xFF1E293B),
    useMaterial3: true,
  );

  static ThemeData pastelTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFDF6F0),
    primaryColor: const Color(0xFFA5D8FF),
    cardColor: const Color(0xFFFFFFFF),
    useMaterial3: true,
  );
}
