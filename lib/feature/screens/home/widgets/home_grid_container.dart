import 'package:flutter/material.dart';

import '/core/components/blur_container.dart';
import '/core/themes/app_dimensions.dart';
import '../../../models/pokemon.dart';
import 'pokemon_card.dart';

class HomeGridContainer extends StatelessWidget {
  final List<Pokemon> pokemonList;

  const HomeGridContainer({
    super.key,
    required this.pokemonList,
  });

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      padding: const EdgeInsets.all(AppDimensions.paddingDefault),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              (MediaQuery.of(context).size.width / 180).floor().clamp(2, 4),
          crossAxisSpacing: AppDimensions.paddingDefault,
          mainAxisSpacing: AppDimensions.paddingDefault,
          childAspectRatio: 1.0,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) =>
            PokemonCard(pokemon: pokemonList[index]),
      ),
    );
  }
}
