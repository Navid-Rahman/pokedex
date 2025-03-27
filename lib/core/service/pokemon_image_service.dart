import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class for managing and retrieving Pokémon image paths from the asset bundle.
class PokemonImageService {
  static Future<List<String>> _cachedImagePaths = Future.value([]);
  static bool _initialized = false;

  /// Initializes the service by loading the asset manifest and caching the paths of pokemon_cards ending with `_new.png`.
  ///
  /// This method should be called before attempting to retrieve image paths. It ensures that the asset
  /// manifest is loaded and the relevant image paths are cached for quick access.
  ///
  /// If the service is already initialized, this method returns immediately.
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Load the asset manifest to get all available pokemon_cards.
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = Map.from(
          manifestContent.isNotEmpty ? json.decode(manifestContent) : {});

      // Filter for Pokémon pokemon_cards ending with `_new.png`.
      _cachedImagePaths = Future.value(manifestMap.keys
          .where((String key) =>
              key.startsWith('assets/pokemon_Images/') &&
              key.endsWith('_new.png'))
          .toList());

      _initialized = true;
    } catch (e) {
      debugPrint('Error initializing PokemonImageService: $e');
      _cachedImagePaths = Future.value([]);
    }
  }

  /// Retrieves the image path for a given Pokémon name.
  ///
  /// This method converts the Pokémon name to the expected file format (underscore-separated with `_new.png`)
  /// and checks if the exact path exists in the cached image paths.
  ///
  /// If the exact path is found, it is returned. Otherwise, the expected path is returned for error handling.
  ///
  /// [pokemonName] - The name of the Pokémon for which to retrieve the image path.
  ///
  /// Returns a [Future<String>] containing the image path.
  static Future<String> getImagePath(String pokemonName) async {
    await initialize();
    final imagePaths = await _cachedImagePaths;

    // Convert Pokémon name to the expected file format (underscore-separated with `_new.png`).
    final formattedName = pokemonName
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('(', '')
        .replaceAll(')', '');
    final expectedPath = 'assets/pokemon_Images/${formattedName}_new.png';

    // Check if the exact path exists in the cached image paths.
    final match = imagePaths.firstWhere(
      (path) => path == expectedPath,
      orElse: () => '',
    );

    // Return the matched path if found, otherwise return the expected path for error handling.
    return match.isNotEmpty ? match : expectedPath;
  }
}
