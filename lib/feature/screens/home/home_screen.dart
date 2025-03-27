import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/app_colors.dart';
import '/core/app_logger.dart';
import '/core/assets.dart';
import '/core/data/pokemon_data.dart';
import '/core/service/auth_service.dart';
import '/core/service/pokemon_filter_service.dart';
import '/core/service/pokemon_search_service.dart';
import '/core/utils/pokedex_loader.dart';
import '../../models/pokemon.dart';
import '../auth_screen.dart';
import 'widgets/home_grid_container.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final allPokemon = useState<List<Pokemon>>([]);
    final filteredPokemon = useState<List<Pokemon>>([]);
    final isLoading = useState(true);
    final searchController = useTextEditingController();
    final sortOrder = useState(PokemonSortOrder.byNumber);

    useEffect(() {
      Future<void> loadPokemon() async {
        AppLogger.info('Loading Pokémon data');
        try {
          final pokemonList = await PokemonData.loadPokemon();
          final sortedList =
              PokemonFilterService.sortPokemon(pokemonList, sortOrder.value);
          allPokemon.value = pokemonList;
          filteredPokemon.value = sortedList;
          isLoading.value = false;
          AppLogger.verbose('Pokémon data loaded successfully');
        } catch (e) {
          isLoading.value = false;
          AppLogger.error('Error loading Pokémon data: $e');
          AppLogger.handle(e, StackTrace.current);
        }
      }

      loadPokemon();
      return null;
    }, const []);

    useEffect(() {
      void updateFilteredList() {
        final searchResults = PokemonSearchService.filterPokemon(
            allPokemon.value, searchController.text);
        filteredPokemon.value =
            PokemonFilterService.sortPokemon(searchResults, sortOrder.value);
        AppLogger.debug('Filtered Pokémon list updated');
      }

      updateFilteredList();
      searchController.addListener(updateFilteredList);
      return () => searchController.removeListener(updateFilteredList);
    }, [searchController.text, sortOrder.value, allPokemon.value]);

    void clearSearch() {
      searchController.clear();
      AppLogger.info('Search cleared');
    }

    void showFilterOptions() {
      AppLogger.info('Showing filter options');
      WoltModalSheet.show<void>(
        context: context,
        pageListBuilder: (BuildContext context) {
          return [
            WoltModalSheetPage(
              backgroundColor: const Color(0xff1A1A1D),
              hasTopBarLayer: true,
              topBarTitle: Text(
                'Sort Pokémon by',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              isTopBarLayerAlwaysVisible: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    _buildSortOption(
                      context,
                      'Number',
                      Icons.tag,
                      sortOrder.value == PokemonSortOrder.byNumber,
                      () {
                        sortOrder.value = PokemonSortOrder.byNumber;
                        AppLogger.info('Sorting by number selected');
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildSortOption(
                      context,
                      'Name',
                      Icons.sort_by_alpha,
                      sortOrder.value == PokemonSortOrder.byName,
                      () {
                        sortOrder.value = PokemonSortOrder.byName;
                        AppLogger.info('Sorting by name selected');
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ];
        },
      );
    }

    Future<void> logout() async {
      AppLogger.info('Logout initiated');
      await Provider.of<AuthService>(context, listen: false).signOut();
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchRow(
                context, searchController, clearSearch, showFilterOptions),
            const SizedBox(height: 24),
            Expanded(
              child: _buildPokemonGridSection(
                  context, isLoading.value, filteredPokemon.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              if (isSelected)
                Icon(Icons.check_circle, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRow(
    BuildContext context,
    TextEditingController controller,
    VoidCallback onClear,
    VoidCallback onFilterTap,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 48,
            child: SearchBar(
              controller: controller,
              backgroundColor: WidgetStateProperty.all(Colors.white),
              leading: Icon(Icons.search, color: AppColors.primaryColor),
              trailing: [
                if (controller.text.isNotEmpty)
                  IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
              ],
              hintText: "Search Pokémon...",
              hintStyle: WidgetStateProperty.all(
                Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Material(
            elevation: 10.0,
            shape: const CircleBorder(),
            child: GestureDetector(
              onTap: onFilterTap,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
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
    if (isLoading) return const PokeDexLoader();
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
            child: HomeGridContainer(pokemonList: pokemonList))
        : HomeGridContainer(pokemonList: pokemonList);
  }
}
