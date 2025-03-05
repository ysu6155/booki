import 'package:booki/core/utils/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/core/widgets/custom_text_field.dart';
import 'package:booki/core/widgets/show_dialog.dart';
import 'package:booki/feature/authentication/data/models/request/register_params.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_state.dart';
import 'package:booki/feature/authentication/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit loginCubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          context.pop();
          showErrorToast(context, state.error);
        } else if (state is LoginSuccess) {
        } else if (state is LoginLoading) {
          showLoadingDialog(context);
        }
      },
      child: Form(
        key: loginCubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 8.sp,
            children: [
              16.H,
              CustomTextField(
                textInputAction: TextInputAction.next,
                controller: loginCubit.emailController,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: LocaleKeys.enterYourEmailOrPhone.tr(),
                keyboardType: TextInputType.emailAddress,
                labelText: LocaleKeys.emailPhone.tr(),
                labelStyle: textStyle.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emailIsRequired.tr();
                  }
                  return null;
                },
              ),
              8.H,
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen:
                    (previous, current) =>
                        current is LoginPasswordVisibilityToggled,
                builder: (context, state) {
                  return CustomTextField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted:
                        (value) => loginCubit.login(
                          RegisterParams(
                            email: loginCubit.emailController.text,
                            password: loginCubit.passwordController.text,
                          ),
                          context,
                        ),
                    controller: loginCubit.passwordController,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: LocaleKeys.password.tr(),
                    labelStyle: textStyle.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                    hintText: "*" * 8,
                    isPassword: true,
                    isPasswordVisible: loginCubit.isPasswordVisible,
                    togglePasswordVisibility: () {
                      loginCubit.togglePasswordVisibility();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.passwordIsRequired.tr();
                      }
                      return null;
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen:
                            (previous, current) =>
                                current is LoginRememberMeToggled,
                        builder: (context, state) {
                          return Checkbox(
                            value: loginCubit.rememberMe,
                            onChanged: (value) {
                              loginCubit.toggleRememberMe(value ?? false);
                            },
                          );
                        },
                      ),
                      Text(
                        LocaleKeys.rememberMe.tr(),
                        style: textStyle.copyWith(
                          color: AppColor.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(ForgotPasswordScreen());
                    },
                    child: Text(
                      " ${LocaleKeys.forgotPassword.tr()}?",
                      style: TextStyle(
                        color: AppColor.main,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              CustomButton(
                name: Text(LocaleKeys.login.tr(), style: textStyle),
                onTap: () {
                  loginCubit.login(
                    RegisterParams(
                      email: loginCubit.emailController.text,
                      password: loginCubit.passwordController.text,
                    ),
                    context,
                  );
                },
              ),
              20.H,
              Row(
                children: [
                  Expanded(child: Divider()),
                  4.W,
                  Text("Or Login with"),
                  4.W,
                  Expanded(child: Divider()),
                ],
              ),
              12.H,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.dark),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppAssets.facbookSVG),
                    ),
                  ),
                  8.W,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.dark),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppAssets.googleSVG),
                    ),
                  ),
                  8.W,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.dark),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppAssets.appelSVG),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
