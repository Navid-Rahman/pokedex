import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';

class StatBar extends StatelessWidget {
  final String label;
  final int base;
  final int min;
  final int max;
  final Color color;
  final IconData icon;
  final double maxBaseValue;

  const StatBar({
    super.key,
    required this.label,
    required this.base,
    required this.min,
    required this.max,
    required this.color,
    required this.icon,
    this.maxBaseValue = 255,
  });

  @override
  Widget build(BuildContext context) {
    final basePercentage = base / maxBaseValue;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppDimensions.paddingDefault),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: AppDimensions.iconSizeSmall),
          ),
          const SizedBox(width: 12),
          // Stat Info
          Expanded(
            child: _buildStatContent(basePercentage),
          ),
        ],
      ),
    );
  }

  Widget _buildStatContent(double basePercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textLightSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              '$base',
              style: const TextStyle(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Base Stat Bar
        _buildStatBar(basePercentage),
        const SizedBox(height: 4),
        // Min-Max Range
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Min: $min',
              style: TextStyle(
                color: AppColors.withOpacity(Colors.white, 0.7),
                fontSize: 12,
              ),
            ),
            Text(
              'Max: $max',
              style: TextStyle(
                color: AppColors.withOpacity(Colors.white, 0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatBar(double basePercentage) {
    return Container(
      width: double.infinity,
      height: 10,
      decoration: BoxDecoration(
        color: AppColors.withOpacity(Colors.white, 0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: basePercentage.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
