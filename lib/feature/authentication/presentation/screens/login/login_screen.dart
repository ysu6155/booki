import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:booki/feature/authentication/presentation/widgets/form_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.dontHaveAnAccount.tr()),
          TextButton(
            onPressed: () {
              context.push(SignUpScreen());
            },
            child: Text(
              LocaleKeys.signUp.tr(),
              style: TextStyle(
                color: AppColor.main,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(backgroundColor: AppColor.white),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            spacing: 8.sp,
            children: [
              Text(
                "Welcome back! Glad to see you, Again!",
                style: textStyle.copyWith(
                  color: AppColor.dark,
                  fontSize: 30.sp,
                ),
              ),
              16.H,
              BlocProvider(
                create: (context) => LoginCubit(),
                child: FormLogin(),
              ),
            ],
          ).paddingAll(22.sp),
        ),
      ),
    );
  }
}
