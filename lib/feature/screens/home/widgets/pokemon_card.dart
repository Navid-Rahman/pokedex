import 'package:flutter/material.dart';

import '/core/service/pokemon_image_service.dart';
import '/core/utils/pokedex_loader.dart';
import '../../../models/pokemon.dart';
import '../../pokemon_details/pokemon_details_screen.dart';
import 'pokemon_image.dart';
import 'positioned_background.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _navigateToPokemonDetails(context);
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
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
      ),
    );
  }

  Future<void> _navigateToPokemonDetails(BuildContext context) async {
    if (!context.mounted) return;
    final imagePath = await PokemonImageService.getImagePath(pokemon.name);
    if (!context.mounted) return;
    Navigator.pushNamed(
      context,
      PokemonDetailsScreen.routeName,
      arguments: {'pokemon': pokemon, 'imagePath': imagePath},
    );
  }
}
