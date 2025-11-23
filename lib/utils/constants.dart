// lib/utils/constants.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF673AB7); // Mor
  static const Color secondary = Color(0xFF9C27B0); // Lila
  static const Color background = Color(0xFFF5F5F5); // Açık Gri
  static const Color error = Color(0xFFE57373); // Kırmızımsı
  static const Color success = Color(0xFF4CAF50); // Yeşil
}

class AppStyles {
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
}

class AppPaddings {
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets verticalSpace = EdgeInsets.symmetric(vertical: 8.0);
}
