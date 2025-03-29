import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isMultiline;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.withOpacity(Colors.white, 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.paddingMedium),
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
            padding: const EdgeInsets.all(AppDimensions.paddingDefault),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child:
                Icon(icon, color: color, size: AppDimensions.iconSizeDefault),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textLightSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textLight,
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
