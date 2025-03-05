import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/authentication/presentation/widgets/form_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.dark),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.H,
              Text(
                "Hello! Register to get started",
                style: textStyle.copyWith(color: AppColor.dark),
              ),
              30.H,
              FormSignUp().paddingAll(16.sp),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.alreadyHaveAnAccount.tr(),
            style: TextStyle(fontSize: 12.sp),
          ),
          TextButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
            child: Text(
              LocaleKeys.login.tr(),
              style: textStyle.copyWith(
                color: AppColor.main,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
