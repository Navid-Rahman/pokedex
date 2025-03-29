import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/data/pokemon_data.dart';
import '/core/extension/snack_bar_x.dart';
import '/core/service/auth_service.dart';
import '/core/service/pokemon_filter_service.dart';
import '/core/service/pokemon_search_service.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '../../../core/components/pokedex_dialogs.dart';
import '../../../core/components/pokedex_loader.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/app_validators.dart';
import '../../../core/utils/assets.dart';
import '../../models/pokemon.dart';
import '../authentication_screen/auth_screen.dart';
import 'widgets/home_grid_container.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final allPokemon = useState<List<Pokemon>>([]);
    final filteredPokemon = useState<List<Pokemon>>([]);
    final isLoading = useState(true);
    final isLoggingOut = useState(false);
    final searchController = useTextEditingController();
    final sortOrder = useState(PokemonSortOrder.byNumber);

    // Load Pokemon data
    useEffect(() {
      _loadPokemonData(
          context, allPokemon, filteredPokemon, isLoading, sortOrder);
      return null;
    }, const []);

    // Filter Pokemon based on search and sort order
    useEffect(() {
      _setupSearchAndFilter(
          searchController, allPokemon, filteredPokemon, sortOrder);
      return () => searchController.removeListener(() {});
    }, [searchController.text, sortOrder.value, allPokemon.value]);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: _buildAppBar(context, isLoggingOut),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          children: [
            _buildSearchRow(
                context,
                searchController,
                () => searchController.clear(),
                () => _showFilterOptions(context, sortOrder)),
            const SizedBox(height: AppDimensions.paddingXLarge),
            Expanded(
              child: _buildPokemonGridSection(
                  context, isLoading.value, filteredPokemon.value),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadPokemonData(
    BuildContext context,
    ValueNotifier<List<Pokemon>> allPokemon,
    ValueNotifier<List<Pokemon>> filteredPokemon,
    ValueNotifier<bool> isLoading,
    ValueNotifier<PokemonSortOrder> sortOrder,
  ) async {
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
      if (context.mounted) {
        context.showErrorSnackBar('Failed to load Pokémon data: $e');
      }
    }
  }

  void _setupSearchAndFilter(
    TextEditingController searchController,
    ValueNotifier<List<Pokemon>> allPokemon,
    ValueNotifier<List<Pokemon>> filteredPokemon,
    ValueNotifier<PokemonSortOrder> sortOrder,
  ) {
    void updateFilteredList() {
      final searchResults = PokemonSearchService.filterPokemon(
          allPokemon.value, searchController.text);
      filteredPokemon.value =
          PokemonFilterService.sortPokemon(searchResults, sortOrder.value);
      AppLogger.debug('Filtered Pokémon list updated');
    }

    updateFilteredList();
    searchController.addListener(updateFilteredList);
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ValueNotifier<bool> isLoggingOut) {
    return AppBar(
      backgroundColor: AppColors.darkBackground,
      leading: SvgPicture.asset(
        Assets.kPokeBallIcon,
        height: 30,
        colorFilter:
            const ColorFilter.mode(AppColors.iconLight, BlendMode.srcATop),
      ),
      title: SvgPicture.asset(
        Assets.kAppTitle,
        height: 30,
      ),
      actions: [
        isLoggingOut.value
            ? const Padding(
                padding: EdgeInsets.all(AppDimensions.paddingDefault),
                child: PokeDexLoader(size: AppDimensions.iconSizeDefault),
              )
            : IconButton(
                icon: const Icon(Icons.logout, color: AppColors.iconLight),
                onPressed: () => _showLogoutDialog(context, isLoggingOut),
                tooltip: 'Logout',
              ),
      ],
    );
  }

  void _showFilterOptions(
      BuildContext context, ValueNotifier<PokemonSortOrder> sortOrder) {
    AppLogger.info('Showing filter options');
    WoltModalSheet.show<void>(
      context: context,
      pageListBuilder: (BuildContext context) {
        return [
          WoltModalSheetPage(
            backgroundColor: AppColors.darkBackground,
            hasTopBarLayer: true,
            topBarTitle: Text(
              'Sort Pokémon by',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            isTopBarLayerAlwaysVisible: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingLarge,
                horizontal: AppDimensions.paddingLarge,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSortOption(context, 'Number', Icons.tag,
                      sortOrder.value == PokemonSortOrder.byNumber, () {
                    sortOrder.value = PokemonSortOrder.byNumber;
                    Navigator.pop(context);
                  }),
                  const SizedBox(height: AppDimensions.paddingDefault),
                  _buildSortOption(context, 'Name', Icons.sort_by_alpha,
                      sortOrder.value == PokemonSortOrder.byName, () {
                    sortOrder.value = PokemonSortOrder.byName;
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
        ];
      },
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
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium,
            horizontal: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            color: AppColors.backdrop,
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusDefault),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.iconLight),
              const SizedBox(width: AppDimensions.paddingLarge),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textLight,
                    ),
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

  Future<void> _showLogoutDialog(
      BuildContext context, ValueNotifier<bool> isLoggingOut) async {
    final shouldLogout = await PokedexDialogs.showLogoutDialog(context);
    if (shouldLogout && context.mounted) {
      isLoggingOut.value = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: PokeDexLoader()),
      );
      try {
        await Provider.of<AuthService>(context, listen: false).signOut();
        if (context.mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          context.showSuccessSnackBar('Logged out successfully');
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.of(context).pop();
          context.showErrorSnackBar('Logout failed: $e');
        }
      } finally {
        if (context.mounted) isLoggingOut.value = false;
      }
    }
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
              backgroundColor:
                  WidgetStateProperty.all(AppColors.cardBackground),
              leading: Icon(Icons.search, color: AppColors.primaryColor),
              trailing: [
                if (controller.text.isNotEmpty)
                  IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
              ],
              hintText: "Search Pokémon...",
              textStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textDark,
                    ),
              ),
              hintStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textDarkSecondary,
                    ),
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onSubmitted: (value) {
                if (AppValidators.required(value) == null) {
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingDefault),
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
                  shape: BoxShape.circle,
                  color: AppColors.cardBackground,
                ),
                child: Icon(
                  Icons.filter_alt,
                  color: AppColors.primaryColor,
                ),
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textLight,
              ),
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
