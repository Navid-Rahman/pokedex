import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/service/auth_service.dart';
import '/core/themes/app_colors.dart';
import '../../core/utils/app_logger.dart';
import '../../core/utils/assets.dart';
import 'authentication_screen/auth_screen.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.info('SplashScreen initialized');
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final user = Provider.of<AuthService>(context, listen: false).currentUser;
    if (user != null) {
      AppLogger.info('User authenticated, navigating to HomeScreen');
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      AppLogger.info('No user authenticated, navigating to AuthScreen');
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Image.asset(
          Assets.kSplashScreen,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
