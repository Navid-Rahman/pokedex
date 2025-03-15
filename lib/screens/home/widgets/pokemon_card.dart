import 'package:flutter/material.dart';
import 'package:pokedex/screens/home/widgets/pokemon_image.dart';
import 'package:pokedex/screens/home/widgets/positioned_background.dart';

import '../../../models/pokemon.dart';
import '../../../service/pokemon_image_service.dart';
import '../../../utils/pokedex_loader.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Stack(
        children: [
          const PositionedBackground(),
          Positioned.fill(
            child: Center(
              child: FutureBuilder<String>(
                future: PokemonImageService.getImagePath(pokemon.name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PokeDexLoader();
                  }

                  final imagePath = snapshot.data ?? '';

                  return PokemonImage(
                      imagePath: imagePath, pokemonName: pokemon.name);
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8.0,
            child: Text(
              pokemon.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Text(
              pokemon.number,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
