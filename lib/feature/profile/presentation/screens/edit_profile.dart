import 'dart:io';
import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/core/widgets/custom_text_field.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:booki/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // 📌 اختيار الصورة من المعرض أو الكاميرا
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // 📌 فتح الـ BottomSheet للاختيار
  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: EdgeInsets.all(16),
            height: 150,
            child: Column(
              children: [
                Text(
                  "Choose Profile Picture",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.photo, size: 40, color: AppColor.main),
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: AppColor.main,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
   AuthCubit signUpCubit = BlocProvider.of<AuthCubit>(context);
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.dark),
        title: Text(
          LocaleKeys.editProfile.tr(),
          style: textStyle.copyWith(color: AppColor.dark),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: CircleAvatar(
                      radius: 70.r,
                      backgroundImage:
                          _imageFile != null
                              ? FileImage(_imageFile!)
                              : AssetImage(AppAssets.welcomeImage)
                                  as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: AppColor.white,
                       child: Icon(Icons.edit, color: AppColor.main),
                    ),
                  ),
                ],
              ),
            ),
            Gap(22),
            CustomTextField(
              controller: signUpCubit.nameController,
              hintText: "name",
            ),
            Gap(22),
            CustomTextField(
              controller: signUpCubit.phoneController,
              hintText: "phone",
            ),
            Gap(22),
            CustomTextField(
              controller: signUpCubit.addressController,
              hintText: "Address",
            ),
            Gap(22),
            CustomButton(
              name: Text("Update Profile", style: textStyle),
              onTap: () {
                profileCubit.updateProfile(
                  _imageFile,
                  signUpCubit.nameController,
                  signUpCubit.phoneController,
                  signUpCubit.addressController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
