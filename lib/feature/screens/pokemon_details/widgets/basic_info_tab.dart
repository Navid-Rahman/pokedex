import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';

class BasicInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  const BasicInfoTab({super.key, required this.pokemon});

  // Process abilities string dynamically
  List<Map<String, String>> _parseAbilities(String? abilities) {
    if (abilities == null || abilities.isEmpty) {
      return [
        {'name': 'Unknown', 'isHidden': 'false'}
      ];
    }

    // Split by comma, trim, and process each ability
    final abilityList =
        abilities.split(',').map((ability) => ability.trim()).toList();
    final parsedAbilities = <Map<String, String>>[];

    for (var ability in abilityList) {
      // Remove numbering if present (e.g., "1.", "2.")
      final cleanedAbility = ability.replaceAll(RegExp(r'^\d+\.\s*'), '');

      // Check for hidden ability indicator dynamically
      bool isHidden = false;
      String abilityName = cleanedAbility;

      // Look for any "(...)" pattern at the end, commonly used for hidden abilities
      final hiddenMatch = RegExp(r'\s*\(([^)]+)\)$').firstMatch(cleanedAbility);
      if (hiddenMatch != null) {
        final suffix = hiddenMatch.group(1)!.toLowerCase();
        // Check if the suffix indicates a hidden ability (flexible check)
        if (suffix.contains('hidden') || suffix == 'ha') {
          isHidden = true;
          abilityName =
              cleanedAbility.replaceAll(hiddenMatch.group(0)!, '').trim();
        }
      }

      parsedAbilities.add({
        'name': abilityName,
        'isHidden': isHidden.toString(),
      });
    }

    return parsedAbilities;
  }

  @override
  Widget build(BuildContext context) {
    final abilities = _parseAbilities(pokemon.abilities);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Basic Info',
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
          _buildInfoCard(
            icon: Icons.eco,
            label: 'Species',
            value: pokemon.species,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            icon: Icons.height,
            label: 'Height',
            value: pokemon.height,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            icon: Icons.fitness_center,
            label: 'Weight',
            value: pokemon.weight,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          _buildAbilitiesCard(abilities: abilities),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilitiesCard({required List<Map<String, String>> abilities}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: Colors.amber.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.2),
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
              color: Colors.amber.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.amber, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Abilities',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: abilities.map((ability) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Row(
                        children: [
                          Text(
                            ability['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontStyle: ability['isHidden'] == 'true'
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                          if (ability['isHidden'] == 'true') ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 2.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Hidden',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
