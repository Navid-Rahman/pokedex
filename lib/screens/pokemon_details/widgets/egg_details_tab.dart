import 'package:flutter/material.dart';

import '/models/pokemon.dart';

class EggDetailsTab extends StatelessWidget {
  final Pokemon pokemon;

  const EggDetailsTab({super.key, required this.pokemon});

  // Format Egg Groups
  String _formatEggGroups(String? eggGroups) {
    if (eggGroups == null || eggGroups.isEmpty) return 'Unknown';
    return eggGroups.split(',').map((group) => group.trim()).join(', ');
  }

  // Format Gender Ratio with text and symbols
  String _formatGenderRatio(String? gender) {
    if (gender == null || gender.isEmpty) return 'Unknown';
    if (gender == 'Genderless') return gender;

    final parts = gender.split(', ');
    if (parts.length != 2) return gender; // Handle unexpected formats

    final malePercentage = RegExp(r'\d+').firstMatch(parts[0])?.group(0) ?? '0';
    final femalePercentage =
        RegExp(r'\d+').firstMatch(parts[1])?.group(0) ?? '0';

    return 'Male ♂ : $malePercentage%\nFemale ♀ : $femalePercentage%';
  }

  // Format Egg Cycles
  String _formatEggCycles(String? eggCycles) {
    if (eggCycles == null || eggCycles.isEmpty) return 'Unknown';

    final cycleMatch = RegExp(r'^\d+').firstMatch(eggCycles);
    final cycles = cycleMatch != null ? cycleMatch.group(0) : 'Unknown';

    final stepsMatch =
        RegExp(r'\(([\d,]+–[\d,]+)\s*steps\)').firstMatch(eggCycles);
    final steps = stepsMatch != null ? ' (${stepsMatch.group(1)} steps)' : '';

    return '$cycles cycles$steps';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Egg Details',
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
          _buildEggCard(
            icon: Icons.group,
            label: 'Egg Groups',
            value: _formatEggGroups(pokemon.eggGroups),
            color: Colors.teal,
            isMultiline: pokemon.eggGroups.contains(','),
          ),
          const SizedBox(height: 12),
          _buildEggCard(
            icon: Icons.wc,
            label: 'Gender Ratio',
            value: _formatGenderRatio(pokemon.gender),
            color: Colors.purple,
            isMultiline: true, // Always multiline for gender ratio
          ),
          const SizedBox(height: 12),
          _buildEggCard(
            icon: Icons.egg,
            label: 'Egg Cycles',
            value: _formatEggCycles(pokemon.eggCycles),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildEggCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isMultiline = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.2,
                  ),
                  overflow: isMultiline ? null : TextOverflow.ellipsis,
                  maxLines: isMultiline ? null : 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
