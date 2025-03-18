import 'package:flutter/material.dart';

import '/models/pokemon.dart';
import 'info_item.dart';

class EggDetailsTab extends StatelessWidget {
  final Pokemon pokemon;

  const EggDetailsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItem(label: 'Egg Groups', value: pokemon.eggGroups),
          InfoItem(label: 'Gender Ratio', value: pokemon.gender),
          InfoItem(label: 'Egg Cycles', value: pokemon.eggCycles.toString()),
        ],
      ),
    );
  }
}
