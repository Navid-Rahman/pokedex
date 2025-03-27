import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import 'home/home_screen.dart';

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

    Future<void> signInWithEmail() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      try {
        await Provider.of<AuthService>(context, listen: false).signInWithEmail(
          emailController.text,
          passwordController.text,
        );
        _navigateToHome(context);
      } catch (e) {
        _showErrorSnackBar(context, e.toString());
      } finally {
        isLoading.value = false;
      }
    }

    Future<void> signUpWithEmail() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      try {
        await Provider.of<AuthService>(context, listen: false).signUpWithEmail(
          emailController.text,
          passwordController.text,
        );
        _navigateToHome(context);
      } catch (e) {
        _showErrorSnackBar(context, e.toString());
      } finally {
        isLoading.value = false;
      }
    }

    Future<void> signInWithGoogle() async {
      isLoading.value = true;
      try {
        final user = await Provider.of<AuthService>(context, listen: false)
            .signInWithGoogle();
        if (user != null) _navigateToHome(context);
      } catch (e) {
        _showErrorSnackBar(context, e.toString());
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(isSignUpMode.value ? 'Sign Up' : 'Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (isLoading.value)
                const CircularProgressIndicator()
              else ...[
                ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: Text(isSignUpMode.value
                      ? 'Sign Up with Email'
                      : 'Sign In with Email'),
                  onPressed:
                      isSignUpMode.value ? signUpWithEmail : signInWithEmail,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => isSignUpMode.value = !isSignUpMode.value,
                  child: Text(
                    isSignUpMode.value
                        ? 'Already have an account? Sign In'
                        : 'New here? Sign Up',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Sign in with Google'),
                  onPressed: signInWithGoogle,
                ),
              ],
            ],
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
