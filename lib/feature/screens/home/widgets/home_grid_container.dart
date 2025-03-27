import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';
import 'pokemon_card.dart';

class HomeGridContainer extends StatelessWidget {
  final List<Pokemon> pokemonList;

  const HomeGridContainer({super.key, required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonList[index];
                  return PokemonCard(pokemon: pokemon);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
