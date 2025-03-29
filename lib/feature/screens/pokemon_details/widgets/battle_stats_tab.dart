import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '/core/themes/app_styles.dart';
import '../../../models/pokemon.dart';
import 'info_card.dart';

class BattleStatsTab extends StatelessWidget {
  final Pokemon pokemon;
  const BattleStatsTab({super.key, required this.pokemon});

  String _formatEVYield(String? evYield) =>
      evYield?.replaceAll(RegExp(r'\d+\s*'), '').trim() ?? 'Unknown';
  String _formatCatchRate(String? catchRate) {
    if (catchRate == null) return 'Unknown';
    final match = RegExp(r'(\d+)\s*\(([\d.]+%[^)]+)\)').firstMatch(catchRate);
    return match != null ? '${match.group(1)} (${match.group(2)})' : catchRate;
  }

  String _formatFriendship(String? friendship) {
    if (friendship == null) return 'Unknown';
    final match = RegExp(r'(\d+)\s*\(([^)]+)\)').firstMatch(friendship);
    return match != null ? '${match.group(1)} - ${match.group(2)}' : friendship;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, 'Battle Stats'),
          const SizedBox(height: AppDimensions.paddingLarge),
          InfoCard(
              icon: Icons.trending_up,
              label: 'EV Yield',
              value: _formatEVYield(pokemon.evYield),
              color: AppColors.hp),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
              icon: Icons.star_border,
              label: 'Base Exp',
              value: pokemon.baseExp.toString(),
              color: AppColors.defense),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
              icon: Icons.catching_pokemon,
              label: 'Catch Rate',
              value: _formatCatchRate(pokemon.catchRate),
              color: AppColors.success),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
              icon: Icons.favorite_border,
              label: 'Friendship',
              value: _formatFriendship(pokemon.baseFriendship),
              color: AppColors.error),
          const SizedBox(height: AppDimensions.paddingMedium),
          InfoCard(
              icon: Icons.speed,
              label: 'Growth Rate',
              value: pokemon.growthRate,
              color: AppColors.spAttack),
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
