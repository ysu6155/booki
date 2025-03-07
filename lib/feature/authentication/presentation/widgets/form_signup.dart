import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/core/widgets/custom_text_field.dart';
import 'package:booki/core/widgets/show_dialog.dart';
import 'package:booki/feature/authentication/data/models/request/register_params.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/layout/presentation/screens/layout/layout_screen.dart';

class FormSignUp extends StatelessWidget {
  const FormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showLoadingDialog(context);
        } else if (state is SignUpSuccess) {
          Navigator.pop(context);
          context.pushAndRemoveUntil(BottomNavigationBarCustom());
        } else if (state is SignUpError) {
          Navigator.pop(context);
          showErrorToast(context, state.error);
        }
      },
      child: Form(
        key: authCubit.formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: authCubit.nameController,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: LocaleKeys.youssifShaban.tr(),
              labelText: LocaleKeys.name.tr(),
              validator:
                  (value) =>
                      value!.isEmpty ? LocaleKeys.nameIsRequired.tr() : null,
            ),
            16.H,
            CustomTextField(
              controller: authCubit.emailController,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: LocaleKeys.exampleEmail.tr(),
              labelText: LocaleKeys.email.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.emailIsRequired.tr();
                }
                return null;
              },
            ),
            16.H,
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen:
                  (previous, current) => current is PasswordVisibilityToggled,
              builder: (context, state) {
                return CustomTextField(
                  labelText: LocaleKeys.password.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: authCubit.passwordController,
                  hintText: "*" * 8,
                  isPassword: true,
                  isPasswordVisible: authCubit.isPasswordVisible,
                  togglePasswordVisibility:
                      authCubit.togglePasswordVisibility,
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? LocaleKeys.passwordIsRequired.tr()
                              : null,
                );
              },
            ),
            16.H,
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen:
                  (previous, current) => current is PasswordVisibilityToggled,
              builder: (context, state) {
                return CustomTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: LocaleKeys.confirmPassword.tr(),
                  controller: authCubit.confirmPasswordController,
                  hintText: "*" * 8,
                  isPassword: true,
                  isPasswordVisible: authCubit.isPasswordVisible,
                  togglePasswordVisibility: () {
                    authCubit.togglePasswordVisibility();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.confirmPasswordIsRequired.tr();
                    }
                    if (value != authCubit.passwordController.text) {
                      return LocaleKeys.PasswordDoesNotMatch.tr();
                    }
                    return null;
                  },
                );
              },
            ),
            16.H,
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen:
                  (previous, current) => current is TermsAgreementToggled,
              builder: (context, state) {
                return Row(
                  children: [
                    Checkbox(
                      value: authCubit.isAgreedToTerms,
                      onChanged: (bool? value) {
                        authCubit.toggleTermsAgreement(value ?? false);
                      },
                    ),
                    Text(
                      LocaleKeys.iAgreeToTermsAndConditions.tr(),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                );
              },
            ),
            12.H,
            CustomButton(
              name: Text(LocaleKeys.signUp.tr(), style: textStyle),
              onTap:
                  () => authCubit.register(
                    RegisterParams(
                      email: authCubit.emailController.text,
                      password: authCubit.passwordController.text,
                      name: authCubit.nameController.text,
                      passwordConfirmation:
                          authCubit.confirmPasswordController.text,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
