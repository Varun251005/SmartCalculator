import 'package:flutter/material.dart';
import 'ui/calculator_screen.dart';
import 'theme/app_themes.dart';

void main() {
  runApp(const SmartCalculator());
}

class SmartCalculator extends StatefulWidget {
  const SmartCalculator({super.key});

  @override
  State<SmartCalculator> createState() => _SmartCalculatorState();
}

class _SmartCalculatorState extends State<SmartCalculator> {
  AppTheme currentTheme = AppTheme.pastel;

  ThemeData get themeData {
    switch (currentTheme) {
      case AppTheme.light:
        return AppThemes.lightTheme;
      case AppTheme.pastel:
        return AppThemes.pastelTheme;
      case AppTheme.dark:
      default:
        return AppThemes.darkTheme;
    }
  }

  void changeTheme(AppTheme theme) {
    setState(() {
      currentTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: CalculatorScreen(onThemeChange: changeTheme, currentTheme: currentTheme),
    );
  }
}
