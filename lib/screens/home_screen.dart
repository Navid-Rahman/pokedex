import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/core/app_colors.dart';
import '/core/assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: SvgPicture.asset(
          Assets.kPokeBallIcon,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
        ),
        title: SvgPicture.asset(
          Assets.kAppTitle,
          height: 30,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Screen!',
            ),
          ],
        ),
      ),
    );
  }
}
