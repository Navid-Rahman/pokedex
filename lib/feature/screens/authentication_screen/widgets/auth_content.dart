import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/extension/snack_bar_x.dart';
import '/core/service/auth_service.dart';
import '/core/themes/app_dimensions.dart';
import '../../../../core/utils/app_logger.dart';
import '../../home/home_screen.dart';
import 'auth_buttons.dart';
import 'auth_form.dart';
import 'auth_title.dart';

class AuthContent extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> isLoading;
  final ValueNotifier<bool> isSignUpMode;

  const AuthContent({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.isSignUpMode,
  });

  @override
  State<AuthContent> createState() => _AuthContentState();
}

class _AuthContentState extends State<AuthContent> {
  Future<void> _signInWithEmail() async {
    if (!widget.formKey.currentState!.validate()) return;
    widget.isLoading.value = true;
    AppLogger.info(
        'Sign-in initiated with email: ${widget.emailController.text}');
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithEmail(
          widget.emailController.text, widget.passwordController.text);
      if (context.mounted) {
        _navigateToHome();
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (context.mounted) {
        widget.isLoading.value = false;
      }
    }
  }

  Future<void> _signUpWithEmail() async {
    if (!widget.formKey.currentState!.validate()) return;
    widget.isLoading.value = true;
    AppLogger.info(
        'Sign-up initiated with email: ${widget.emailController.text}');
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signUpWithEmail(
          widget.emailController.text, widget.passwordController.text);
      if (context.mounted) {
        _navigateToHome();
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (context.mounted) {
        widget.isLoading.value = false;
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    widget.isLoading.value = true;
    AppLogger.info('Google sign-in initiated');
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithGoogle();
      if (context.mounted && user != null) {
        _navigateToHome();
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (context.mounted) {
        widget.isLoading.value = false;
      }
    }
  }

  void _navigateToHome() {
    AppLogger.info('Navigating to HomeScreen');
    context.showSuccessSnackBar('Logged in successfully');
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(isSignUpMode: widget.isSignUpMode.value),
        const SizedBox(height: AppDimensions.paddingXLarge),
        AuthForm(
          formKey: widget.formKey,
          emailController: widget.emailController,
          passwordController: widget.passwordController,
        ),
        const SizedBox(height: AppDimensions.paddingXLarge),
        AuthButtons(
          isLoading: widget.isLoading.value,
          isSignUpMode: widget.isSignUpMode.value,
          onSignIn: _signInWithEmail,
          onSignUp: _signUpWithEmail,
          onGoogleSignIn: _signInWithGoogle,
          onToggleMode: () =>
              widget.isSignUpMode.value = !widget.isSignUpMode.value,
        ),
      ],
    );
  }
}
