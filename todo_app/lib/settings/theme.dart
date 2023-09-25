import 'package:flutter/material.dart';
import 'package:todo_app/settings/responsive.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade400,
        primary: Colors.blue.shade600,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: !Responsive.isMobile(context) ? 38.0 : 28.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        titleMedium: TextStyle(
          fontSize: !Responsive.isMobile(context) ? 26.0 : 22.0,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: !Responsive.isMobile(context) ? 27.0 : 24.0,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: !Responsive.isMobile(context) ? 20.0 : 17.0,
        ),
        bodySmall: TextStyle(
          fontSize: !Responsive.isMobile(context) ? 16.0 : 14.0,
        ),
      ),
    );
  }
}
