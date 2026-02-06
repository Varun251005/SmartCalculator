import 'package:flutter/material.dart';
import '../theme/app_themes.dart';

class CalculatorScreen extends StatefulWidget {
  final Function(AppTheme) onThemeChange;
  final AppTheme currentTheme;

  const CalculatorScreen({
    super.key,
    required this.onThemeChange,
    required this.currentTheme,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";
  String input = "";
  double first = 0;
  String operator = "";
  bool explain = false;
  String explanation = "";

  void onPress(String value) {
    setState(() {
      if (value == "C") {
        clear();
      } else if ("+-×÷".contains(value)) {
        if (input.isNotEmpty) {
          first = double.parse(input);
          operator = value;
          input = "";
          display = operator;
        }
      } else if (value == "=") {
        calculate();
      } else {
        input += value;
        display = input;
      }
    });
  }

  void calculate() {
    try {
      if (input.isEmpty || operator.isEmpty) return;

      double second = double.parse(input);
      double result = 0;

      switch (operator) {
        case "+":
          result = first + second;
          explanation = "Add $first and $second to get $result";
          break;
        case "-":
          result = first - second;
          explanation = "Subtract $second from $first to get $result";
          break;
        case "×":
          result = first * second;
          explanation = "Multiply $first by $second to get $result";
          break;
        case "÷":
          if (second == 0) {
            error();
            return;
          }
          result = first / second;
          explanation = "Divide $first by $second to get $result";
          break;
      }

      display = result.toStringAsFixed(2);
      input = display;
    } catch (_) {
      error();
    }
  }

  void error() {
    display = "Error";
    explanation = "Invalid calculation";
    input = "";
    operator = "";
  }

  void clear() {
    display = "0";
    input = "";
    first = 0;
    operator = "";
    explanation = "";
  }

  Widget buildThemeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Theme 🎨",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          DropdownButton<AppTheme>(
            value: widget.currentTheme,
            underline: Container(),
            items: const [
              DropdownMenuItem(value: AppTheme.light, child: Text("☀️ Light")),
              DropdownMenuItem(value: AppTheme.dark, child: Text("🌙 Dark")),
              DropdownMenuItem(
                value: AppTheme.pastel,
                child: Text("🎨 Pastel"),
              ),
            ],
            onChanged: (theme) {
              if (theme != null) {
                widget.onThemeChange(theme);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Theme Selector
              buildThemeSelector(),
              const SizedBox(height: 20),
              // Display Area
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Text(
                          display,
                          key: ValueKey(display),
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      if (explain && explanation.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            explanation,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Explain Toggle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explain My Answer 🧠",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Switch(
                      value: explain,
                      onChanged: (v) {
                        setState(() {
                          explain = v;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Buttons Grid
              Expanded(
                flex: 3,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    btn("7"),
                    btn("8"),
                    btn("9"),
                    btn("+"),
                    btn("4"),
                    btn("5"),
                    btn("6"),
                    btn("-"),
                    btn("1"),
                    btn("2"),
                    btn("3"),
                    btn("×"),
                    btn("0"),
                    btn("C"),
                    btn("="),
                    btn("÷"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btn(String t) {
    bool isOperator = "+-×÷=".contains(t);
    bool isEquals = t == "=";
    bool isClear = t == "C";

    Color btnColor;
    Color textColor;

    if (widget.currentTheme == AppTheme.pastel) {
      // Pastel theme
      if (t == "+") {
        btnColor = const Color(0xFF80D8FF);
        textColor = Colors.white;
      } else if (t == "-") {
        btnColor = const Color(0xFFFFE082);
        textColor = const Color(0xFF555555);
      } else if (t == "×") {
        btnColor = const Color(0xFF81C784);
        textColor = Colors.white;
      } else if (t == "=") {
        btnColor = const Color(0xFFEF9A9A);
        textColor = Colors.white;
      } else if (t == "C") {
        btnColor = const Color(0xFFF5F5F5);
        textColor = const Color(0xFF333333);
      } else {
        btnColor = const Color(0xFFFFFFFF);
        textColor = const Color(0xFF333333);
      }
    } else if (widget.currentTheme == AppTheme.light) {
      // Light theme
      if (isOperator) {
        btnColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
      } else if (isClear) {
        btnColor = Colors.grey.shade300;
        textColor = Colors.grey.shade700;
      } else {
        btnColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
      }
    } else {
      // Dark theme
      if (isOperator) {
        btnColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
      } else if (isClear) {
        btnColor = Colors.grey.shade800;
        textColor = Colors.grey.shade300;
      } else {
        btnColor = Colors.grey.shade900;
        textColor = Colors.grey.shade100;
      }
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress(t),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: btnColor,
            boxShadow: [
              BoxShadow(
                color: btnColor.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            t,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
