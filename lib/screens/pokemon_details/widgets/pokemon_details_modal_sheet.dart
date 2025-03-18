import 'dart:ui';

import 'package:flutter/material.dart';

import '/core/app_colors.dart';
import '/models/pokemon.dart';
import 'pokemon_details_content.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsModal({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: Color(0xff1A1A1D),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  child: Stack(
                    children: [
                      PokemonDetailsContent(pokemon: pokemon),
                      // Floating close button positioned relative to header
                      Positioned(
                        top: 8, // Align with header padding
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
