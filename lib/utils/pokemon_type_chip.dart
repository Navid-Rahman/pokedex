import 'dart:ui';

import 'package:flutter/material.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;

  PokemonTypeChip({super.key, required this.type});

  final Map<String, Color> typeColors = {
    "Bug": Color(0xFF92BC2C),
    "Dark": Color(0xFF595761),
    "Dragon": Color(0xFF0C69C8),
    "Electric": Color(0xFFF2D94E),
    "Fairy": Color(0xFFEE90E6),
    "Fighting": Color(0xFFD3425F),
    "Fire": Color(0xFFFBA54C),
    "Flying": Color(0xFFA1BBEC),
    "Ghost": Color(0xFF5F6DBC),
    "Grass": Color(0xFF5FBD58),
    "Ground": Color(0xFFDA7C4D),
    "Ice": Color(0xFF75D0C1),
    "Normal": Color(0xFFA0A29F),
    "Poison": Color(0xFFB763CF),
    "Psychic": Color(0xFFFA8581),
    "Rock": Color(0xFFC9BB8A),
    "Steel": Color(0xFF5695A3),
    "Water": Color(0xFF539DDF),
  };

  @override
  Widget build(BuildContext context) {
    // Get the type color or default to grey
    final Color typeColor = typeColors[type] ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  typeColor.withValues(alpha: 0.6),
                  typeColor.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: typeColor.withValues(alpha: 0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: typeColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Text(
              type,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: typeColor.withValues(alpha: 0.7),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
