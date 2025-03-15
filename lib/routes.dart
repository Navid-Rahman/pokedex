import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';
import 'screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
