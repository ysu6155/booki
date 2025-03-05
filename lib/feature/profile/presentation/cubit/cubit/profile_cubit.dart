import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:booki/feature/profile/data/rebo/profile_rebo.dart';
import 'package:booki/feature/welcome/presentation/screens/welcome/welcome_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
      final response = await ProfileRepository.getProfileData();
      emit(
        ProfileLoaded(
          name: response.data?.name ?? "",
          email: response.data?.email ?? "No Email",
          image: response.data?.image ?? "",
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(ProfileError("Failed to load profile: $e"));
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedHelper.removeKey(SharedKeys.kToken);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
      (route) => false,
    );
  }

  Future<void> updateProfile(
    File? imageFile,
    TextEditingController name,
    TextEditingController phone,
    TextEditingController address,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name.text,
        "phone": phone.text,
        "address": address.text,
        if (imageFile != null)
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: "profile.jpg",
          ),
      });

      Response response = await ProfileRepository.updateProfile(formData);

      if (response.statusCode == 200) {
        log("✅ Profile updated successfully!");
        name.clear();
        phone.clear();
        address.clear();
      } else {
        log("❌ Error: \${response.statusMessage}");
      }
    } catch (e) {
      log("❌ Exception: $e");
    }
  }

  Future<void> updatePassword() async {
    emit(ProfileLoading());
    try {
      final response = await ProfileRepository.updatePassword({
        "current_password": currentPasswordController.text,
        "new_password": newPasswordController.text,
        "new_password_confirmation": confirmPasswordController.text,
      });

      if (response.statusCode == 200) {
        emit(ProfileSuccess("Password updated successfully!"));
        log("Password updated successfully!");
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
      } else {
        emit(ProfileError("Failed to update password"));
        log("Error: ${response.statusMessage}");
      }
    } catch (e) {
      log("❌ Exception: $e");
      
      emit(ProfileError("Failed to update password"));
    }
  }
}
