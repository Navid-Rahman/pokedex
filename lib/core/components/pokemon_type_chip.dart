import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/app_dimensions.dart';
import 'pokemon_types.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;

  const PokemonTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final PokemonType pokemonType = PokemonTypes.types[type] ??
        PokemonType(type: type, color: Colors.grey, imagePath: '');

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium, vertical: 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  pokemonType.color.withValues(alpha: 0.6),
                  pokemonType.color.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: pokemonType.color.withValues(alpha: 0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: pokemonType.color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Type icon
                if (pokemonType.imagePath.isNotEmpty)
                  SvgPicture.asset(
                    pokemonType.imagePath,
                    height: 40,
                    width: 40,
                  ),
                // Type text
                Text(
                  pokemonType.type,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: pokemonType.color.withValues(alpha: 0.7),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
