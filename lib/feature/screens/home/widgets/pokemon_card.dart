import 'package:flutter/material.dart';

import '/core/service/pokemon_image_service.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/feature/models/pokemon.dart';
import '/feature/screens/home/widgets/pokemon_image.dart';
import '/feature/screens/home/widgets/positioned_background.dart';
import '/feature/screens/pokemon_details/pokemon_details_screen.dart';
import '../../../../core/components/pokedex_loader.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _navigateToPokemonDetails(context);
      },
      child: Card(
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
            _buildInfoLabels(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoLabels(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: AppDimensions.paddingDefault,
          child: Text(
            pokemon.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDark,
                ),
          ),
        ),
        Positioned(
          top: AppDimensions.paddingDefault,
          right: AppDimensions.paddingDefault,
          child: Text(
            pokemon.number,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textDarkSecondary,
                ),
          ),
        ),
      ],
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
