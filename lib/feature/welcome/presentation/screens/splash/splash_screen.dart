import 'dart:developer';

import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/layout/presentation/screens/layout/layout_screen.dart';
import 'package:booki/feature/welcome/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String? token = SharedHelper.get(SharedKeys.kToken);
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (token != null) {
      context.pushReplacement(const BottomNavigationBarCustom());
    } else {
      context.pushReplacement(const WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoSVG),
            9.H,
            Text(
              "Order Your Book Now!",
              style: textStyle.copyWith(color: AppColor.dark),
            ),
          ],
        ),
      ),
    );
  }
}
