import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/core/themes/app_colors.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xff1A1A1D), // Dark background
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0.0,
          backgroundColor: Color(0xff1A1A1D),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
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
          fontFamily: 'Poppins',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          surface: Color(0xff1A1A1D),
          onSurface: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 5,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white70,
            textStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.primaryColor,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      );

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
          const Color(0xff1A1A1D), // Match scaffold background
      systemNavigationBarIconBrightness: backgroundBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
