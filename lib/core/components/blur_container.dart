import 'dart:ui';

import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_dimensions.dart';
import '../themes/app_styles.dart';

/// Base class for containers with backdrop blur effect
class BlurContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final ImageFilter? blurFilter;

  const BlurContainer({
    super.key,
    required this.child,
    this.borderRadius = AppDimensions.borderRadiusDefault,
    this.backgroundColor = AppColors.backdrop,
    this.padding = EdgeInsets.zero,
    this.blurFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: blurFilter ?? AppStyles.defaultBlur,
          child: Container(
            color: backgroundColor,
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
