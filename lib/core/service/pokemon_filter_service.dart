import '../../feature/models/pokemon.dart';

enum PokemonSortOrder {
  byNumber,
  byName,
}

class PokemonFilterService {
  /// Sorts the provided Pokemon list based on the sort order
  static List<Pokemon> sortPokemon(
      List<Pokemon> pokemonList, PokemonSortOrder sortOrder) {
    final sortedList = List<Pokemon>.from(pokemonList);

    switch (sortOrder) {
      case PokemonSortOrder.byNumber:
        sortedList.sort((a, b) {
          // Remove any non-numeric characters and convert to int for proper numeric sorting
          final aNum =
              int.tryParse(a.number.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
          final bNum =
              int.tryParse(b.number.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
          return aNum.compareTo(bNum);
        });
        break;
      case PokemonSortOrder.byName:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return sortedList;
  }
}
