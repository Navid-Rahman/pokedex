import 'package:flutter/material.dart';

import '/feature/models/pokemon.dart';
import '/feature/screens/home/home_screen.dart';
import '/feature/screens/pokemon_details/pokemon_details_screen.dart';
import '/feature/screens/splash_screen.dart';
import '../../feature/screens/authentication_screen/auth_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  AuthScreen.routeName: (context) => const AuthScreen(),
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
