import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF232F69);
  static const Color primaryShadow = Color.fromRGBO(35, 47, 105, 0.08);
  static const Color white = Color(0xFFFFFFFF);

  // grey colors
  static const Color border = Color.fromRGBO(222, 224, 227, 1);
  static const Color grey = Color.fromRGBO(134, 140, 152, 0.75);
  static const Color lightGrey = Color.fromRGBO(222, 224, 227, 0.5);
  static const Color greyIndicator = Color.fromRGBO(217, 217, 217, 1);

  // auxiliary colors
  static const Color success = Color(0xFF54B73B);
  static const Color successDark = Color(0xFF2C681D);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF00BCD4);

  // Text Colors
  static const Color textPrimary = Color(0xFF37404E);
  static const Color textSecondary = Color(0xFF5E646E);

  // background colors
  static const Color scaffoldBackground = Color(0xFFF4F5F6);

  // shimmer gradient colors
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xFFF1EFEF), Color(0xFFF9F8F8), Color(0xFFE7E5E5)],
  );
}
