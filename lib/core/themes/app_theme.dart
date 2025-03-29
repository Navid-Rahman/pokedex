import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/core/themes/app_colors.dart';

import 'app_dimensions.dart';

class AppTheme {
  static const _fontFamily = 'Poppins';

  static ThemeData get theme => ThemeData(
        fontFamily: _fontFamily,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.darkBackground,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.textLight,
        ),
        textTheme: _buildTextTheme(),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          onPrimary: AppColors.textLight,
          surface: AppColors.darkBackground,
          onSurface: AppColors.textLight,
        ),
        elevatedButtonTheme: _buildElevatedButtonTheme(),
        outlinedButtonTheme: _buildOutlinedButtonTheme(),
        textButtonTheme: _buildTextButtonTheme(),
        inputDecorationTheme: _buildInputDecorationTheme(),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.primaryColor,
          contentTextStyle: TextStyle(color: AppColors.textLight),
        ),
        cardTheme: _buildCardTheme(),
      );

  // Extract text theme building for better organization
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 96),
      displayMedium: TextStyle(fontSize: 80),
      displaySmall: TextStyle(fontSize: 72),
      headlineLarge: TextStyle(fontSize: 64),
      headlineMedium: TextStyle(fontSize: 56),
      headlineSmall: TextStyle(fontSize: 48),
      titleLarge: TextStyle(fontSize: 44),
      titleMedium: TextStyle(fontSize: 40),
      titleSmall: TextStyle(fontSize: 36),
      labelLarge: TextStyle(fontSize: 28),
      labelMedium: TextStyle(fontSize: 24),
      labelSmall: TextStyle(fontSize: 20),
      bodyLarge: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 12),
    ).apply(
      fontFamily: _fontFamily,
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textLight,
    );
  }

  // Extract button themes for better organization
  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textLight,
        padding:
            const EdgeInsets.symmetric(vertical: AppDimensions.paddingLarge),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusDefault),
        ),
        elevation: 5,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.textLight),
        padding:
            const EdgeInsets.symmetric(vertical: AppDimensions.paddingLarge),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusDefault),
        ),
        foregroundColor: AppColors.textLight,
        textStyle: const TextStyle(
          fontSize: 20,
          fontFamily: _fontFamily,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textLightSecondary,
        textStyle: const TextStyle(
          fontSize: 16,
          fontFamily: _fontFamily,
        ),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.textLightSecondary),
      filled: true,
      fillColor: AppColors.withOpacity(Colors.white, 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
        borderSide: BorderSide(color: AppColors.withOpacity(Colors.white, 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.borderRadiusDefault)),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.borderRadiusDefault)),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.borderRadiusDefault)),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }

  static CardTheme _buildCardTheme() {
    return CardTheme(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
      ),
      shadowColor: AppColors.textLight,
      surfaceTintColor: AppColors.textLight,
      color: AppColors.cardBackground,
    );
  }

  // Helper method to get status bar style based on background brightness
  static SystemUiOverlayStyle getStatusBarStyle(
      {required Brightness backgroundBrightness}) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent to extend background
      statusBarIconBrightness: backgroundBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: backgroundBrightness == Brightness.dark
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor:
          AppColors.darkBackground, // Match scaffold background
      systemNavigationBarIconBrightness: backgroundBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
