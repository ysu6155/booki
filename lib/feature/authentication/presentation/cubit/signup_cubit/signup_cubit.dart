import 'package:bloc/bloc.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';
import 'package:booki/feature/authentication/data/models/request/register_params.dart';
import 'package:booki/feature/authentication/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';

import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

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

  String? selectedGender;
  String? selectedCity;
  bool isPasswordVisible = false;
  bool isAgreedToTerms = false;
  String? selectedAccountType;

  void selectAccountType(String? accountType) {
    selectedAccountType = accountType;
    emit(AccountTypeSelected(selectedAccountType));
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityToggled(isPasswordVisible));
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

      if (result != null) {
        SharedHelper.sava(SharedKeys.kToken, result.data?.token);
        emit(SignUpSuccess());
      } else {
        emit(SignUpError("LocaleKeys.signUpFailed.tr()")); // رسالة خطأ مترجمة
      }
    } catch (e) {
      emit(SignUpError(e.toString())); // خطأ عام
    }
  }
}
