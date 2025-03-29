import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '/core/components/blur_container.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '../../../core/components/pokemon_type_chip.dart';
import '../../../core/utils/assets.dart';
import '../../models/pokemon.dart';
import 'widgets/pokemon_details_modal_sheet.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Pokemon pokemon;
  final String imagePath;

  static const routeName = '/pokemon-details';

  const PokemonDetailsScreen({
    super.key,
    required this.pokemon,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDetailsModal(context),
        backgroundColor: AppColors.darkBackground,
        child:
            const Icon(Icons.info_outline_rounded, color: AppColors.iconLight),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.iconLight),
        backgroundColor: AppColors.darkBackground,
        title: Text(
          pokemon.name,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Platform.isIOS
                  ? SafeArea(
                      top: false,
                      bottom: true,
                      child: _buildContainer(context),
                    )
                  : _buildContainer(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsModal(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        pageBuilder: (context, _, __) => Align(
          alignment: Alignment.centerRight,
          child: PokemonDetailsModal(pokemon: pokemon),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return BlurContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    Assets.kForestCard,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final size = constraints.maxHeight * 0.7 <
                              constraints.maxWidth * 0.6
                          ? constraints.maxHeight * 0.7
                          : constraints.maxWidth * 0.6;
                      return Align(
                        alignment: const Alignment(0.0, 0.4),
                        child: Image.asset(
                          imagePath,
                          height: size,
                          width: size,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingLarge,
              ),
              child: Wrap(
                spacing: AppDimensions.paddingDefault,
                runSpacing: AppDimensions.paddingDefault,
                children: pokemon.type
                    .split(',')
                    .map((type) => PokemonTypeChip(type: type.trim()))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
