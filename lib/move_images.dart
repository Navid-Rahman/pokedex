import 'dart:io';

void main() {
  final sourceDir = Directory('../assets/Pokemon_Images_DB');
  final targetDir = Directory('../assets/Pokemon_Images');

  if (!sourceDir.existsSync()) {
    print('Source directory does not exist: ${sourceDir.path}');
    return;
  }

  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  sourceDir.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('_new.png')) {
      final segments = entity.path.split(Platform.pathSeparator);
      var fileName = segments.last;

      // Remove brackets, replace spaces and hyphens with underscores
      fileName = fileName
          .replaceAll('_', ' ')
          .replaceAll(' ', '_')
          .replaceAll('-', '_')
          .replaceAll(RegExp(r'[\(\)]'), '');

      final newPath = '${targetDir.path}/$fileName';

      entity.copySync(newPath);
    }
  });

  print('Images moved successfully!');
}
