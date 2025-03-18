import 'package:flutter/material.dart';

import '/models/pokemon.dart';
import 'info_item.dart';

class BasicInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  const BasicInfoTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItem(label: 'Species', value: pokemon.species),
          InfoItem(label: 'Height', value: '${pokemon.height} m'),
          InfoItem(label: 'Weight', value: '${pokemon.weight} kg'),
          InfoItem(label: 'Abilities', value: pokemon.abilities),
        ],
      ),
    );
  }
}
