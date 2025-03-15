import 'package:flutter/material.dart';

import '/models/pokemon.dart';
import '../service/pokemon_image_service.dart';

class HomeGridContainer extends StatelessWidget {
  final List<Pokemon> pokemonList;

  const HomeGridContainer({super.key, required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
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

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 80,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: FutureBuilder<String>(
                        future: PokemonImageService.getImagePath(pokemon.name),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          }

                          final imagePath = snapshot.data ?? '';

                          return Image.asset(
                            imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback when image can't be found
                              print(
                                  'Failed to load image: $imagePath for ${pokemon.name}');
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.catching_pokemon,
                                      size: 40, color: Colors.grey),
                                  const SizedBox(height: 4),
                                  Text(
                                    'No image',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                ],
                              );
                            },
                          );
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
          },
        ),
      ),
    );
  }
}
