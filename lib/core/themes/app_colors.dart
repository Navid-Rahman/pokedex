import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Basic colors
  static const transparent = Colors.transparent;

  // Brand colors
  static const primaryColor = Color(0xFFFF0505);
  static const secondaryColor = Color(0xFFEFEFEF);

  // Background colors
  static const darkBackground = Color(0xff1A1A1D);
  static const cardBackground = Colors.white;

  // Transparency helpers
  static Color withOpacity(Color color, double opacity) =>
      color.withOpacity(opacity);

  // Common color combinations
  static const textDark = Colors.black38;
  static const textLight = Colors.white;
  static const textLightSecondary = Colors.white70;
  static const textDarkSecondary = Color(0xFF606060);

  // Status colors
  static const success = Colors.green;
  static const error = Colors.redAccent;
  static const warning = Colors.orange;
  static const info = Colors.teal;

  // UI Element colors
  static const backdrop = Colors.white10;
  static const divider = Colors.white24;
  static const iconLight = Colors.white;
  static const iconDark = Colors.black;

  // Stats colors
  static final hp = Colors.red.shade400;
  static final attack = Colors.orange.shade400;
  static final defense = Colors.yellow.shade600;
  static final spAttack = Colors.blue.shade400;
  static final spDefense = Colors.green.shade400;
  static final speed = Colors.purple.shade400;
}
