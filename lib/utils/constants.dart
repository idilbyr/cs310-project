import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF7E57C2);
  static const Color accentColor = Color(0xFF81C784);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);
  static const Color primary = Color(0xFF673AB7); // Mor
  static const Color secondary = Color(0xFF9C27B0); // Lila
  static const Color background = Color(0xFFF5F5F5); // Açık Gri
  static const Color error = Color(0xFFE57373); // Kırmızımsı
  static const Color success = Color(0xFF4CAF50); // Yeşil
}

class AppTextStyles {
  static const TextStyle headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily: 'Roboto',

  );
  static const TextStyle title = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.primary
  );
  static const TextStyle body = TextStyle(fontSize: 16);
  static const TextStyle link = TextStyle(
      fontSize: 14,
      color: AppColors.secondary,
      decoration: TextDecoration.underline
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

class AppPaddings {
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets verticalSpace = EdgeInsets.symmetric(vertical: 8.0);
}