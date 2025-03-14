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
        // Set Poppins as the default font family
        fontFamily: 'Poppins', // Match the family name from pubspec.yaml
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
          bodySmall: TextStyle(),
          headlineLarge: TextStyle(),
          headlineMedium: TextStyle(),
          headlineSmall: TextStyle(),
        ).apply(fontFamily: 'Poppins'),

        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
    );
  }
}
