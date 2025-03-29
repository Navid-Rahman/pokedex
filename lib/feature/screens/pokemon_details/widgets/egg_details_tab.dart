import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/core/themes/app_styles.dart';
import '../../../models/pokemon.dart';
import 'info_card.dart';

class EggDetailsTab extends StatelessWidget {
  final Pokemon pokemon;
  const EggDetailsTab({super.key, required this.pokemon});

  String _formatEggGroups(String? eggGroups) =>
      eggGroups?.split(',').map((group) => group.trim()).join(', ') ??
      'Unknown';
  String _formatGenderRatio(String? gender) {
    if (gender == null || gender.isEmpty) return 'Unknown';
    if (gender == 'Genderless') return gender;
    final parts = gender.split(', ');
    if (parts.length != 2) return gender;
    final male = RegExp(r'\d+').firstMatch(parts[0])?.group(0) ?? '0';
    final female = RegExp(r'\d+').firstMatch(parts[1])?.group(0) ?? '0';
    return 'Male ♂: $male%\nFemale ♀: $female%';
  }

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
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, 'Egg Details'),
          const SizedBox(height: AppDimensions.paddingLarge),
          InfoCard(
            icon: Icons.group,
            label: 'Egg Groups',
            value: _formatEggGroups(pokemon.eggGroups),
            color: AppColors.info,
            isMultiline: pokemon.eggGroups.contains(','),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
            icon: Icons.wc,
            label: 'Gender Ratio',
            value: _formatGenderRatio(pokemon.gender),
            color: AppColors.spAttack,
            isMultiline: true,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
            icon: Icons.egg,
            label: 'Egg Cycles',
            value: _formatEggCycles(pokemon.eggCycles),
            color: AppColors.warning,
          ),
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
}
