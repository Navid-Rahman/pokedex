import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../feature/models/pokemon.dart';

class PokemonData {
  static Future<List<Pokemon>> loadPokemon() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/pokemonDB_dataset.json');
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.entries
        .toList()
        .asMap()
        .entries
        .map((entry) =>
            Pokemon.fromJson(entry.value.key, entry.value.value, entry.key))
        .toList();
  }
}
