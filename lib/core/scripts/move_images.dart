import 'dart:io';

import 'package:flutter/cupertino.dart';

/// This script moves and renames image files from the source directory to the target directory.
/// - Only files ending with `_new.png` are processed.
/// - Brackets `(` and `)` in file names are removed.
/// - Spaces and hyphens `-` in file names are replaced with underscores `_`.
/// - The script assumes the source directory is located at `../assets/Pokemon_Images_DB`
///   and the target directory is located at `../assets/pokemon_Images`.

void main() {
  /// Define source and target directories
  final sourceDir = Directory('../assets/Pokemon_Images_DB');
  final targetDir = Directory('../assets/pokemon_Images');

  /// Check if the source directory exists
  if (!sourceDir.existsSync()) {
    debugPrint('Source directory does not exist: ${sourceDir.path}');
    return;
  }

  /// Create the target directory if it doesn't exist
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  /// List all files in the source directory recursively
  sourceDir.listSync(recursive: true).forEach((entity) {
    // Process only files ending with `_new.png`
    if (entity is File && entity.path.endsWith('_new.png')) {
      final segments = entity.path.split(Platform.pathSeparator);
      var fileName = segments.last;

      /// Remove brackets, replace spaces and hyphens with underscores
      fileName = fileName
          .replaceAll('_', ' ')
          .replaceAll(' ', '_')
          .replaceAll('-', '_')
          .replaceAll(RegExp(r'[\(\)]'), '');

      /// Define the new path for the file in the target directory
      final newPath = '${targetDir.path}/$fileName';

      /// Copy the file to the new path
      entity.copySync(newPath);
    }
  });

  /// Print success message
  debugPrint('Images moved successfully!');
}
