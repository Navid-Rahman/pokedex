import 'package:flutter/material.dart';

class FallbackImage extends StatelessWidget {
  const FallbackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.catching_pokemon, size: 40, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          'No image',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
