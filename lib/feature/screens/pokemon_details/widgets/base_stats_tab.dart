import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';
import 'stat_bar.dart';

class BaseStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  const BaseStatsTab({super.key, required this.pokemon});

  // Calculate total base stats
  int _calculateTotalBaseStats() {
    return (pokemon.hpBase) +
        (pokemon.attackBase) +
        (pokemon.defenseBase) +
        (pokemon.specialAttackBase) +
        (pokemon.specialDefenseBase) +
        (pokemon.speedBase);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Base Stats',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Stat Bars
          StatBar(
            label: 'HP',
            base: pokemon.hpBase,
            min: pokemon.hpMin,
            max: pokemon.hpMax,
            color: Colors.red,
            icon: Icons.favorite,
          ),
          StatBar(
            label: 'Attack',
            base: pokemon.attackBase,
            min: pokemon.attackMin,
            max: pokemon.attackMax,
            color: Colors.orange,
            icon: Icons.sports_martial_arts,
          ),
          StatBar(
            label: 'Defense',
            base: pokemon.defenseBase,
            min: pokemon.defenseMin,
            max: pokemon.defenseMax,
            color: Colors.blue,
            icon: Icons.shield,
          ),
          StatBar(
            label: 'Sp. Atk',
            base: pokemon.specialAttackBase,
            min: pokemon.specialAttackMin,
            max: pokemon.specialAttackMax,
            color: Colors.purple,
            icon: Icons.auto_awesome,
          ),
          StatBar(
            label: 'Sp. Def',
            base: pokemon.specialDefenseBase,
            min: pokemon.specialDefenseMin,
            max: pokemon.specialDefenseMax,
            color: Colors.teal,
            icon: Icons.security,
          ),
          StatBar(
            label: 'Speed',
            base: pokemon.speedBase,
            min: pokemon.speedMin,
            max: pokemon.speedMax,
            color: Colors.green,
            icon: Icons.directions_run,
          ),
          const SizedBox(height: 16),
          // Total Base Stats
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.equalizer,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Text(
                  _calculateTotalBaseStats().toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
