import 'package:flutter/material.dart';

import 'models/pokemon.dart';
import 'screens/home/home_screen.dart';
import 'screens/pokemon_details_screen.dart';
import 'screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  PokemonDetailsScreen.routeName: (context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return PokemonDetailsScreen(
      pokemon: args['pokemon'] as Pokemon,
      imagePath: args['imagePath'] as String,
    );
  },
};
