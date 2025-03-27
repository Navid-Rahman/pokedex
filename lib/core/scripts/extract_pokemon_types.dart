import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() async {
  // Get the current script's directory
  final scriptDir = Directory.current;
  final projectRoot = scriptDir.parent.parent;

  final inputFile =
      File('${projectRoot.path}/assets/data/pokemonDB_dataset.json');
  final outputFile = File('${projectRoot.path}/assets/data/pokemon_types.txt');

  try {
    // Create data directory if it doesn't exist
    await Directory('${projectRoot.path}/assets/data').create(recursive: true);

    // Read the JSON file
    final jsonString = await inputFile.readAsString();
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    // Extract Pokémon types
    final Set<String> pokemonTypes = {};

    for (var pokemon in jsonData.values) {
      // Cast the split result to List<String> explicitly
      final types = pokemon['Type']
          .toString()
          .split(',')
          .map((type) => type.trim())
          .toList(); // Convert to List<String>
      pokemonTypes.addAll(types);
    }

    // Write the types to the output file
    final typesList = pokemonTypes.toList()..sort();
    await outputFile.writeAsString(typesList.join('\n'));

    debugPrint(
        'Pokémon types have been extracted and written to ${outputFile.path}');
  } catch (e) {
    debugPrint('Error: $e');
    debugPrint('Current directory: ${Directory.current.path}');
    debugPrint('Input file path: ${inputFile.path}');
  }
}
