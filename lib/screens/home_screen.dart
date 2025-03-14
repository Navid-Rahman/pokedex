import 'dart:io' show Platform; // For platform detection

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/data/pokemon_data.dart';

import '/core/app_colors.dart';
import '/core/assets.dart';
import '../models/pokemon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
              ],
            ),
            const SizedBox(height: 24),
            // White container takes remaining height with platform-specific handling
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: PokemonData.loadPokemon(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Pokémon data found'));
                  }

                  final pokemonList = snapshot.data!.take(50).toList();

                  return Platform.isIOS
                      ? SafeArea(
                          top: false,
                          bottom: true,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  pokemonList.length,
                                  (index) => Container(
                                    height: 100,
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        pokemonList[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                pokemonList.length,
                                (index) => Container(
                                  height: 100,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      pokemonList[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
