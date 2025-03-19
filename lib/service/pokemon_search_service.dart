import '/models/pokemon.dart';

class PokemonSearchService {
  /// Filters the provided Pokemon list based on the search query
  static List<Pokemon> filterPokemon(List<Pokemon> allPokemon, String query) {
    if (query.isEmpty) {
      return allPokemon;
    }

    final normalizedQuery = query.toLowerCase().trim();

    return allPokemon.where((pokemon) {
      // Search by name
      final nameMatch = pokemon.name.toLowerCase().contains(normalizedQuery);

      // Search by number
      final numberMatch =
          pokemon.number.toLowerCase().contains(normalizedQuery);

      // You can add more search criteria here (types, abilities, etc.)
      // For example, if Pokemon has a types field:
      // final typeMatch = pokemon.types.any((type) => type.toLowerCase().contains(normalizedQuery));

      return nameMatch || numberMatch;
    }).toList();
  }
}
