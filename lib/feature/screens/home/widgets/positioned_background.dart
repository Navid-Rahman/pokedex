import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_dimensions.dart';

class PositionedBackground extends StatelessWidget {
  const PositionedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppDimensions.borderRadiusDefault),
            bottomRight: Radius.circular(AppDimensions.borderRadiusDefault),
            topLeft: Radius.circular(AppDimensions.borderRadiusMedium),
            topRight: Radius.circular(AppDimensions.borderRadiusMedium),
          ),
        ),
      ),
    );
  }
}
