import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/utils/pokedex_loader.dart';

import '/core/app_colors.dart';
import '/core/assets.dart';
import '/data/pokemon_data.dart';
import '/models/pokemon.dart';
import 'widgets/home_grid_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1A1D),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1A1D),
        leading: SvgPicture.asset(
          Assets.kPokeBallIcon,
          height: 30,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
        ),
        title: SvgPicture.asset(
          Assets.kAppTitle,
          height: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search row
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 48,
                    child: SearchBar(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      leading: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      hintText: "Search Pokémon...",
                      hintStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    elevation: 10.0,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      child: Container(
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.filter_alt),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // White container takes remaining height with platform-specific handling
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: PokemonData.loadPokemon(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return PokeDexLoader();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Pokémon data found'));
                  }

                  final pokemonList = snapshot.data!.toList();

                  return Platform.isIOS
                      ? SafeArea(
                          top: false,
                          bottom: true,
                          child: HomeGridContainer(pokemonList: pokemonList),
                        )
                      : HomeGridContainer(pokemonList: pokemonList);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
