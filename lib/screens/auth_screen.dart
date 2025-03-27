import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/core/assets.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import 'home/home_screen.dart';

class AuthScreen extends HookWidget {
  static const String routeName = '/auth';

  const AuthScreen({super.key});

  Future<void> _signInWithEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    ValueNotifier<bool> isLoading,
  ) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signInWithEmail(
        emailController.text,
        passwordController.text,
      );
      if (context.mounted) {
        _navigateToHome(context);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, e.toString());
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }

  Future<void> _signUpWithEmail(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    ValueNotifier<bool> isLoading,
  ) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signUpWithEmail(
        emailController.text,
        passwordController.text,
      );
      if (context.mounted) {
        _navigateToHome(context);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, e.toString());
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }

  Future<void> _signInWithGoogle(
    BuildContext context,
    ValueNotifier<bool> isLoading,
  ) async {
    isLoading.value = true;
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithGoogle();
      if (context.mounted && user != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, e.toString());
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final isSignUpMode = useState(false);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  width: 400,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          isSignUpMode.value ? 'Sign Up' : 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        if (isLoading.value)
                          const Center(child: CircularProgressIndicator())
                        else ...[
                          ElevatedButton(
                            onPressed: () => isSignUpMode.value
                                ? _signUpWithEmail(
                                    context,
                                    formKey,
                                    emailController,
                                    passwordController,
                                    isLoading,
                                  )
                                : _signInWithEmail(
                                    context,
                                    formKey,
                                    emailController,
                                    passwordController,
                                    isLoading,
                                  ),
                            child: Text(
                                isSignUpMode.value ? 'Sign Up' : 'Sign In'),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            icon: SvgPicture.asset(
                              Assets.kGoogleIcon,
                              height: 36,
                            ),
                            label: const Text('Sign in with Google'),
                            onPressed: () =>
                                _signInWithGoogle(context, isLoading),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () =>
                                isSignUpMode.value = !isSignUpMode.value,
                            child: Text(
                              isSignUpMode.value
                                  ? 'Already have an account? Sign In'
                                  : 'New here? Sign Up',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
