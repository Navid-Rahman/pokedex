import 'package:flutter/material.dart';

import 'core/app_theme.dart';
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
      theme: AppTheme.theme,
      initialRoute: SplashScreen.routeName,
    );
  }
}
