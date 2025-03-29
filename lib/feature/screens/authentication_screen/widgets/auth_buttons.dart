import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/core/assets.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import '../../../../core/components/pokedex_loader.dart';

class AuthButtons extends StatelessWidget {
  final bool isLoading;
  final bool isSignUpMode;
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onToggleMode;

  const AuthButtons({
    super.key,
    required this.isLoading,
    required this.isSignUpMode,
    required this.onSignIn,
    required this.onSignUp,
    required this.onGoogleSignIn,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isLoading)
          const Center(
              child: PokeDexLoader(size: AppDimensions.iconSizeDefault))
        else ...[
          ElevatedButton(
            onPressed: isSignUpMode ? onSignUp : onSignIn,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingLarge),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusDefault),
              ),
            ),
            child: Text(isSignUpMode ? 'Sign Up' : 'Sign In'),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          OutlinedButton.icon(
            icon: SvgPicture.asset(
              Assets.kGoogleIcon,
              height: AppDimensions.iconSizeLarge,
            ),
            label: const Text('Sign in with Google'),
            onPressed: onGoogleSignIn,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingLarge),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusDefault),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          TextButton(
            onPressed: onToggleMode,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: isSignUpMode
                        ? 'Already have an account? '
                        : 'New here? ',
                    style: const TextStyle(color: AppColors.textLightSecondary),
                  ),
                  TextSpan(
                    text: isSignUpMode ? 'Sign In' : 'Sign Up',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
