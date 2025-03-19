import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/core/app_colors.dart';
import '/core/assets.dart';
import '/data/pokemon_data.dart';
import '/models/pokemon.dart';
import '/service/pokemon_search_service.dart';
import '../../utils/pokedex_loader.dart';
import 'widgets/home_grid_container.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // State hooks
    final allPokemon = useState<List<Pokemon>>([]);
    final filteredPokemon = useState<List<Pokemon>>([]);
    final isLoading = useState(true);
    final searchController = useTextEditingController();

    // Effect hook for loading Pokemon
    useEffect(() {
      Future<void> loadPokemon() async {
        try {
          final pokemonList = await PokemonData.loadPokemon();
          allPokemon.value = pokemonList;
          filteredPokemon.value = pokemonList;
          isLoading.value = false;
        } catch (e) {
          isLoading.value = false;
          debugPrint('Error loading Pokemon: $e');
        }
      }

      loadPokemon();
      return null;
    }, const []);

    // Effect hook for search changes
    useEffect(() {
      void onSearchChanged() {
        final query = searchController.text;
        filteredPokemon.value =
            PokemonSearchService.filterPokemon(allPokemon.value, query);
      }

      // Add listener
      searchController.addListener(onSearchChanged);

      // Cleanup function
      return () {
        searchController.removeListener(onSearchChanged);
      };
    }, [searchController, allPokemon.value]); // Dependencies for this effect

    // Clear search function
    void clearSearch() {
      searchController.clear();
    }

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
            _buildSearchRow(context, searchController, clearSearch),
            const SizedBox(height: 24),
            // Pokemon list
            Expanded(
              child: _buildPokemonGridSection(
                  context, isLoading.value, filteredPokemon.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context, TextEditingController controller,
      VoidCallback onClear) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
              height: 48,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SearchBar(
                  controller: controller,
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  leading: Icon(
                    Icons.search,
                    color: AppColors.primaryColor,
                  ),
                  trailing: [
                    if (controller.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: onClear,
                      ),
                  ],
                  hintText: "Search Pokémon...",
                  hintStyle: WidgetStateProperty.all(
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              )),
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
    );
  }

  Widget _buildPokemonGridSection(
      BuildContext context, bool isLoading, List<Pokemon> pokemonList) {
    if (isLoading) {
      return const PokeDexLoader();
    }

    if (pokemonList.isEmpty) {
      return Center(
        child: Text(
          'No Pokémon found',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      );
    }

    return Platform.isIOS
        ? SafeArea(
            top: false,
            bottom: true,
            child: HomeGridContainer(pokemonList: pokemonList),
          )
        : HomeGridContainer(pokemonList: pokemonList);
  }
}
