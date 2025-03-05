import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String error;
  LoginError(this.error);
}

class LoginPasswordVisibilityToggled extends AuthState {
  final bool isVisible;
  LoginPasswordVisibilityToggled(this.isVisible);
}

class LoginRememberMeToggled extends AuthState {
  final bool isRemembered;
  LoginRememberMeToggled(this.isRemembered);
}

class SignUpInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {
  final String error;
  SignUpError(this.error);
}

class PasswordVisibilityToggled extends AuthState {
  final bool isPasswordVisible;
  PasswordVisibilityToggled(this.isPasswordVisible);
}

class GenderSelected extends AuthState {
  final String? selectedGender;
  GenderSelected(this.selectedGender);
}

class CitySelected extends AuthState {
  final String? selectedCity;
  CitySelected(this.selectedCity);
}

class TermsAgreementToggled extends AuthState {
  final bool isAgreed;
  TermsAgreementToggled(this.isAgreed);
}

class AccountTypeSelected extends AuthState {
  final String? selectedAccountType;
  AccountTypeSelected(this.selectedAccountType);
}
