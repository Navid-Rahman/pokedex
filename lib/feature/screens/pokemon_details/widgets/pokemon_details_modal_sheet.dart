import 'package:flutter/material.dart';

import '/core/components/blur_container.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/core/themes/app_styles.dart';
import '../../../models/pokemon.dart';
import 'pokemon_details_content.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsModal({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(color: AppColors.darkBackground),
          child: BlurContainer(
            child: Stack(
              children: [
                PokemonDetailsContent(pokemon: pokemon),
                Positioned(
                  top: AppDimensions.paddingDefault,
                  right: AppDimensions.paddingDefault,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: AppStyles.defaultShadow,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: AppColors.iconDark),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
