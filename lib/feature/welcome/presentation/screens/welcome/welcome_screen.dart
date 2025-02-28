import 'package:booki/core/themes/light_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:booki/feature/welcome/presentation/widgets/build_pge_welcome.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.welcomeImage,
              fit: BoxFit.fill,
              width: double.infinity,
              alignment: Alignment.topLeft,
            ),
            Positioned(
              bottom: 94,
              top: 135,
              right: 22,
              left: 22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  35.H,
                  buildPage(
                    image: AppAssets.imageBooki,
                    title: "Order Your Book Now!",
                  ),
                  Spacer(),
                  20.H,
                  CustomButton(
                    name: Text(LocaleKeys.login.tr(), style: textStyle),
                    onTap: () {
                      context.push(LoginScreen());
                    },
                  ),
                  16.H,
                  CustomButton(
                    border: Border.all(color: AppColor.dark, width: 1.sp),
                    name: Text(
                      LocaleKeys.signUp.tr(),
                      style: textStyle.copyWith(color: AppColor.black),
                    ),
                    backgroundColor: AppColor.white,
                    textColor: AppColor.dark,
                    onTap: () {
                      context.push(SignUpScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
