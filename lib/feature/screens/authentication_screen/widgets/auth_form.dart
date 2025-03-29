import 'package:flutter/material.dart';

import '/core/themes/app_dimensions.dart';
import '../../../../core/utils/app_validators.dart';
import 'auth_field.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.email,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          AuthField(
            controller: passwordController,
            label: 'Password',
            icon: Icons.lock,
            obscureText: true,
            validator: AppValidators.password,
          ),
        ],
      ),
    );
  }
}
