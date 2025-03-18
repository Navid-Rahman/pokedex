import 'package:flutter/material.dart';

import '/models/pokemon.dart';
import 'stat_bar.dart';

class BaseStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  const BaseStatsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatBar(label: 'HP', value: pokemon.hpBase),
          StatBar(label: 'Attack', value: pokemon.attackBase),
          StatBar(label: 'Defense', value: pokemon.defenseBase),
          StatBar(label: 'Special Attack', value: pokemon.specialAttackBase),
          StatBar(label: 'Special Defense', value: pokemon.specialDefenseBase),
          StatBar(label: 'Speed', value: pokemon.speedBase),
        ],
      ),
    );
  }
}
