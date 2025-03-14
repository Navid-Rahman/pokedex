import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéDex',
      routes: routes,
      theme: ThemeData(
        fontFamily: 'Poppins',
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
        ).apply(fontFamily: 'Poppins'),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
    );
  }
}
