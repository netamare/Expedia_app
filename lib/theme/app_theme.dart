import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: AppColors.accent),
    // Updated TextTheme names for newer Flutter SDKs
    textTheme: TextTheme(
      titleLarge: TextStyle(color: AppColors.textPrimary, fontSize: 20),
      bodyMedium: TextStyle(color: AppColors.muted),
    ),
  );
}