import 'package:flutter/material.dart';

import '/core/themes/app_colors.dart';
import '/core/themes/app_styles.dart';

class AuthTitle extends StatelessWidget {
  final bool isSignUpMode;

  const AuthTitle({super.key, required this.isSignUpMode});

  @override
  Widget build(BuildContext context) {
    return Text(
      isSignUpMode ? 'Sign Up' : 'Sign In',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textLight,
            shadows: AppStyles.defaultShadow,
          ),
      textAlign: TextAlign.center,
    );
  }
}
