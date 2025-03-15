import 'dart:convert';

import 'package:flutter/services.dart';

class PokemonImageService {
  static Future<List<String>> _cachedImagePaths = Future.value([]);
  static bool _initialized = false;

  // Initialize the service by scanning the assets directory
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Load the asset manifest to get all available images
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = Map.from(
          manifestContent.isNotEmpty ? json.decode(manifestContent) : {});

      // Filter for Pokémon images ending with "_new.png"
      _cachedImagePaths = Future.value(manifestMap.keys
          .where((String key) =>
              key.startsWith('assets/Pokemon_Images/') &&
              key.endsWith('_new.png'))
          .toList());

      _initialized = true;
    } catch (e) {
      print('Error initializing PokemonImageService: $e');
      _cachedImagePaths = Future.value([]);
    }
  }

  // Get image path for a Pokémon name
  static Future<String> getImagePath(String pokemonName) async {
    await initialize();
    final imagePaths = await _cachedImagePaths;

    // Convert Pokémon name to the expected file format (underscore-separated with _new.png)
    final formattedName = '${pokemonName.replaceAll(" ", "_")}_new.png';
    final expectedPath = 'assets/Pokemon_Images/$formattedName';

    // Check if the exact path exists in the cached image paths
    final match = imagePaths.firstWhere(
      (path) => path == expectedPath,
      orElse: () => '',
    );

    // Return the matched path if found, otherwise return the expected path for error handling
    return match.isNotEmpty ? match : expectedPath;
  }
}
