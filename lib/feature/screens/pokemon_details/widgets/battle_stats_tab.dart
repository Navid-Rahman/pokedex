import 'package:flutter/material.dart';

import '../../../models/pokemon.dart';

class BattleStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  const BattleStatsTab({super.key, required this.pokemon});

  // Format EV Yield to remove numbers and clarify
  String _formatEVYield(String? evYield) {
    if (evYield == null) return 'Unknown';
    // Remove redundant numbering if present
    return evYield.replaceAll(RegExp(r'\d+\s*'), '').trim();
  }

  // Extract just the catch rate number and percentage
  String _formatCatchRate(String? catchRate) {
    if (catchRate == null) return 'Unknown';
    final match = RegExp(r'(\d+)\s*\(([\d.]+%[^)]+)\)').firstMatch(catchRate);
    return match != null ? '${match.group(1)} (${match.group(2)})' : catchRate;
  }

  // Format base friendship to show value and description
  String _formatFriendship(String? friendship) {
    if (friendship == null) return 'Unknown';
    final match = RegExp(r'(\d+)\s*\(([^)]+)\)').firstMatch(friendship);
    return match != null ? '${match.group(1)} - ${match.group(2)}' : friendship;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with Pokémon flair
          Text(
            'Battle Stats',
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
          _buildStatCard(
            icon: Icons.trending_up, // EV Yield
            label: 'EV Yield',
            value: _formatEVYield(pokemon.evYield),
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            icon: Icons.star_border,
            label: 'Base Exp',
            value: pokemon.baseExp.toString(),
            color: Colors.yellow,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            icon: Icons.catching_pokemon,
            label: 'Catch Rate',
            value: _formatCatchRate(pokemon.catchRate),
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            icon: Icons.favorite_border,
            label: 'Friendship',
            value: _formatFriendship(pokemon.baseFriendship),
            color: Colors.pink,
          ),
          const SizedBox(height: 12),
          _buildStatCard(
            icon: Icons.speed,
            label: 'Growth Rate',
            value: pokemon.growthRate,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
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
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
