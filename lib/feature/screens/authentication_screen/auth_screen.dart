import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '/core/components/blur_container.dart';
import '/core/themes/app_colors.dart';
import '/core/themes/app_dimensions.dart';
import 'widgets/auth_content.dart';

class AuthScreen extends HookWidget {
  static const String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final isSignUpMode = useState(false);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: BlurContainer(
              borderRadius: AppDimensions.borderRadiusLarge,
              padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AuthContent(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                  isLoading: isLoading,
                  isSignUpMode: isSignUpMode,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
