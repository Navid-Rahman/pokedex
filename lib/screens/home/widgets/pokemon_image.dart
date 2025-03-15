import 'package:flutter/material.dart';

import 'fallback_image.dart';

class PokemonImage extends StatelessWidget {
  final String imagePath;
  final String pokemonName;

  const PokemonImage({
    super.key,
    required this.imagePath,
    required this.pokemonName,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback when image can't be found
        print('Failed to load image: $imagePath for $pokemonName');
        return const FallbackImage();
      },
    );
  }
}
