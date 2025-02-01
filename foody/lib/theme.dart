import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(33, 37, 41,1);
  static Color primaryAccent = const Color.fromRGBO(52, 58, 64, 1);
  static Color secondaryColor = const Color.fromRGBO(248, 249, 250, 1);
  static Color secondaryAccent = const Color.fromRGBO(233, 236, 239, 1);
  static Color titleColor = const Color.fromRGBO(173, 181, 189, 1);
  static Color textColor = const Color.fromRGBO(108, 117, 125, 1);
}

ThemeData primaryTheme = ThemeData(
  // Seed Color

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor
  ),

  // Scaffold Color

  scaffoldBackgroundColor: AppColors.secondaryAccent,

  // App Bar Color

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.primaryAccent,
      fontSize: 16,
      letterSpacing: 1
    ),
    headlineMedium: TextStyle(
      color: AppColors.primaryAccent,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1
    ),
    titleMedium: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2
    ),
  ),

  cardTheme: CardTheme(
    color: AppColors.secondaryColor.withValues(alpha: 0.5 ),
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(),
    shadowColor: Colors.transparent,
    margin: const EdgeInsets.only(bottom: 16),
  ),

  // Input Decoration Theme

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor.withValues(alpha: 0.5),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: TextStyle(color: AppColors.textColor),
    prefixIconColor: AppColors.textColor,
  ),
  
  // Dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.secondaryColor,
    surfaceTintColor: Colors.transparent,
  )

);