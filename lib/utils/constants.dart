import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF7E57C2);
  static const Color accentColor = Color(0xFF81C784);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
}

class AppTextStyles {
  static const TextStyle headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily: 'Roboto',
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}
