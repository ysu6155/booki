import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/authentication/data/models/request/register_params.dart';
import 'package:booki/feature/authentication/data/repo/auth_repo.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_state.dart';
import 'package:booki/feature/layout/presentation/screens/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberMe = false;
  String? selectedGender;
  String? selectedCity;

  bool isAgreedToTerms = false;
  String? selectedAccountType;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityToggled(isPasswordVisible));
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(LoginRememberMeToggled(rememberMe));
  }

  Future<void> login(RegisterParams params, BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());
    try {
      final response = await AuthRepo.login(params);
      await SharedHelper.sava(SharedKeys.kToken, response.data?.token);
      await SharedHelper.sava(SharedKeys.name, response.data?.user?.name);
      await SharedHelper.sava(SharedKeys.email, response.data?.user?.email);
      await SharedHelper.sava(SharedKeys.image, response.data?.user?.image);

      emit(LoginSuccess());

      if (context.mounted) {
        context.pushAndRemoveUntil(const BottomNavigationBarCustom());
      }
        } catch (e, stackTrace) {
      log("🔥 Login Error: $e");
      log("📌 StackTrace: $stackTrace");
      emit(LoginError("An error occurred. Please try again."));
    }
  }
  //

  final List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Sharm El Sheikh',
    'Hurghada',
    'Luxor',
    'Aswan',
    'Port Said',
    'Suez',
    'Tanta',
    'Mansoura',
    'Damanhur',
    'Ismailia',
    'Minya',
    'Beni Suef',
    'Fayoum',
    'Qena',
    'Sohag',
  ];

  void selectAccountType(String? accountType) {
    selectedAccountType = accountType;
    emit(AccountTypeSelected(selectedAccountType));
  }

  void selectGender(String? gender) {
    selectedGender = gender;
    emit(GenderSelected(selectedGender));
  }

  void selectCity(String? city) {
    selectedCity = city;
    emit(CitySelected(selectedCity));
  }

  void toggleTermsAgreement(bool value) {
    isAgreedToTerms = value;
    emit(TermsAgreementToggled(isAgreedToTerms));
  }

  // void signUp(BuildContext context) {
  // if (!formKey.currentState!.validate()) return;
  //if (!isAgreedToTerms) {
  //emit(SignUpError("يجب الموافقة على الشروط والأحكام"));
  // return;
  //   }
  // emit(SignUpLoading());

  // محاكاة API Call
  // Future.delayed(Duration(seconds: 2), () {
  // context.pushAndRemoveUntil(TapBarScreen());
  // emit(SignUpSuccess());
  // });
  // }

  Future<void> register(RegisterParams params) async {
    if (!formKey.currentState!.validate()) return;

    if (!isAgreedToTerms) {
      emit(SignUpError("ocaleKeys.agreeToTermsError.tr()")); // استخدم الترجمة
      return;
    }

    emit(SignUpLoading());

    try {
      final result = await AuthRepo.register(params); // استخدام async/await

      SharedHelper.sava(SharedKeys.kToken, result.data?.token);
      emit(SignUpSuccess());
        } catch (e) {
      emit(SignUpError(e.toString())); // خطأ عام
    }
  }
}
