import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PokemonImageService {
  // Singleton instance
  static final PokemonImageService _instance = PokemonImageService._internal();
  factory PokemonImageService() => _instance;
  PokemonImageService._internal();

  // Cache manager for keeping track of loaded images
  final cacheManager = DefaultCacheManager();

  // Memory cache to avoid duplicate lookups
  final Map<String, String> _imagePathCache = {};

  // Asset bundle to check if assets exist
  final AssetBundle _assetBundle = rootBundle;

  // Get image path for a pokemon, with fallback logic
  Future<String> getImagePath(String pokemonName) async {
    if (_imagePathCache.containsKey(pokemonName)) {
      return _imagePathCache[pokemonName]!;
    }

    final formattedName = pokemonName.trim(); // Keep spaces, just trim

    final primaryPath =
        'assets/Pokemon_Images_DB/$formattedName/${formattedName}_new.png';
    final fallbackPath =
        'assets/Pokemon_Images_DB/$formattedName/$formattedName.png';

    try {
      await _assetBundle.load(primaryPath);
      _imagePathCache[pokemonName] = primaryPath;
      return primaryPath;
    } catch (e) {
      try {
        await _assetBundle.load(fallbackPath);
        _imagePathCache[pokemonName] = fallbackPath;
        return fallbackPath;
      } catch (e) {
        final placeholderPath = 'assets/images/placeholder_pokemon.png';
        _imagePathCache[pokemonName] = placeholderPath;
        return placeholderPath;
      }
    }
  }

  // Preload a batch of Pokemon images into memory
  Future<void> preloadPokemonImages(List<String> pokemonNames) async {
    final futures = <Future>[];

    for (final name in pokemonNames) {
      futures.add(getImagePath(name).then((path) {
        // Precache the image in the image cache
        return precacheImage(
            AssetImage(path), NavigationService.navigatorKey.currentContext!);
      }));
    }

    await Future.wait(futures);
  }

  // Clear cache when no longer needed
  void clearCache() {
    _imagePathCache.clear();
    cacheManager.emptyCache();
  }
}

// Helper service to access BuildContext from anywhere for image precaching
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
