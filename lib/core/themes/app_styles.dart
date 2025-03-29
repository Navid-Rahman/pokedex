import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  const AppStyles._();

  // Common blur effect
  static ImageFilter get defaultBlur =>
      ImageFilter.blur(sigmaX: 10, sigmaY: 10);

  // Common box shadows
  static List<BoxShadow> get defaultShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ];

  // Common gradients
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [AppColors.primaryColor, Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
