import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/material.dart';

import '/core/assets.dart';
import '/core/utils/pokemon_type_chip.dart';
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
      backgroundColor: const Color(0xff1A1A1D),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              barrierColor: Colors.black.withValues(alpha: 0.5),
              pageBuilder: (context, _, __) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: PokemonDetailsModal(pokemon: pokemon),
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        backgroundColor: const Color(0xff1A1A1D),
        child: const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff1A1A1D),
        title: Text(
          pokemon.name,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
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
        padding: const EdgeInsets.all(8.0),
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

  Widget _buildContainer(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                            // Calculate dynamic size based on available space
                            final size = constraints.maxHeight * 0.7 <
                                    constraints.maxWidth * 0.6
                                ? constraints.maxHeight * 0.7
                                : constraints.maxWidth * 0.6;

                            return Align(
                              // Position the Pokemon 20% below center
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

                // Pokemon Type Row with some padding
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ...pokemon.type.split(',').map(
                              (type) => PokemonTypeChip(type: type.trim()),
                            ),
                      ],
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
