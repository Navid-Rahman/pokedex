import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/core/themes/app_styles.dart';
import '../../../models/pokemon.dart';
import 'info_card.dart';

class BasicInfoTab extends StatelessWidget {
  final Pokemon pokemon;
  const BasicInfoTab({super.key, required this.pokemon});

  List<Map<String, String>> _parseAbilities(String? abilities) {
    if (abilities == null || abilities.isEmpty) {
      return [
        {'name': 'Unknown', 'isHidden': 'false'}
      ];
    }
    final abilityList =
        abilities.split(',').map((ability) => ability.trim()).toList();
    final parsedAbilities = <Map<String, String>>[];
    for (var ability in abilityList) {
      final cleanedAbility = ability.replaceAll(RegExp(r'^\d+\.\s*'), '');
      bool isHidden = false;
      String abilityName = cleanedAbility;
      final hiddenMatch = RegExp(r'\s*\(([^)]+)\)$').firstMatch(cleanedAbility);
      if (hiddenMatch != null) {
        final suffix = hiddenMatch.group(1)!.toLowerCase();
        if (suffix.contains('hidden') || suffix == 'ha') {
          isHidden = true;
          abilityName =
              cleanedAbility.replaceAll(hiddenMatch.group(0)!, '').trim();
        }
      }
      parsedAbilities
          .add({'name': abilityName, 'isHidden': isHidden.toString()});
    }
    return parsedAbilities;
  }

  @override
  Widget build(BuildContext context) {
    final abilities = _parseAbilities(pokemon.abilities);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, 'Basic Info'),
          const SizedBox(height: AppDimensions.paddingLarge),
          InfoCard(
            icon: Icons.eco,
            label: 'Species',
            value: pokemon.species,
            color: AppColors.success,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
            icon: Icons.height,
            label: 'Height',
            value: pokemon.height,
            color: AppColors.info,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
            icon: Icons.fitness_center,
            label: 'Weight',
            value: pokemon.weight,
            color: AppColors.textDarkSecondary,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildAbilitiesCard(abilities),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.bold,
            shadows: AppStyles.defaultShadow,
          ),
    );
  }

  Widget _buildAbilitiesCard(List<Map<String, String>> abilities) {
    return InfoCard(
      icon: Icons.star,
      label: 'Abilities',
      value: abilities
          .map((a) => a['name']! + (a['isHidden'] == 'true' ? ' (Hidden)' : ''))
          .join('\n'),
      color: AppColors.warning,
      isMultiline: true,
    );
  }
}
