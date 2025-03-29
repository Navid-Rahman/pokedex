import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/core/themes/app_styles.dart';
import '../../../models/pokemon.dart';
import 'stat_bar.dart';

class BaseStatsTab extends StatelessWidget {
  final Pokemon pokemon;
  const BaseStatsTab({super.key, required this.pokemon});

  int _calculateTotalBaseStats() {
    return pokemon.hpBase +
        pokemon.attackBase +
        pokemon.defenseBase +
        pokemon.specialAttackBase +
        pokemon.specialDefenseBase +
        pokemon.speedBase;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, 'Base Stats'),
          const SizedBox(height: AppDimensions.paddingLarge),
          StatBar(
              label: 'HP',
              base: pokemon.hpBase,
              min: pokemon.hpMin,
              max: pokemon.hpMax,
              color: AppColors.hp,
              icon: Icons.favorite),
          StatBar(
              label: 'Attack',
              base: pokemon.attackBase,
              min: pokemon.attackMin,
              max: pokemon.attackMax,
              color: AppColors.attack,
              icon: Icons.sports_martial_arts),
          StatBar(
              label: 'Defense',
              base: pokemon.defenseBase,
              min: pokemon.defenseMin,
              max: pokemon.defenseMax,
              color: AppColors.defense,
              icon: Icons.shield),
          StatBar(
              label: 'Sp. Atk',
              base: pokemon.specialAttackBase,
              min: pokemon.specialAttackMin,
              max: pokemon.specialAttackMax,
              color: AppColors.spAttack,
              icon: Icons.auto_awesome),
          StatBar(
              label: 'Sp. Def',
              base: pokemon.specialDefenseBase,
              min: pokemon.specialDefenseMin,
              max: pokemon.specialDefenseMax,
              color: AppColors.spDefense,
              icon: Icons.security),
          StatBar(
              label: 'Speed',
              base: pokemon.speedBase,
              min: pokemon.speedMin,
              max: pokemon.speedMax,
              color: AppColors.speed,
              icon: Icons.directions_run),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildTotalStats(context),
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

  Widget _buildTotalStats(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.backdrop,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.equalizer, color: AppColors.defense),
              const SizedBox(width: AppDimensions.paddingDefault),
              const Text(
                'Total',
                style: TextStyle(
                  color: AppColors.textLightSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Text(
            _calculateTotalBaseStats().toString(),
            style: TextStyle(
              color: AppColors.defense,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
