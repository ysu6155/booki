import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/core/widgets/custom_text_field.dart';
import 'package:booki/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();

            return ListView(
              children: [
                Gap(45),
                Center(
                  child: Text(
                    "New Password",
                    style: textStyle.copyWith(
                      color: AppColor.dark,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                Gap(73),
                CustomTextField(
                  controller: cubit.currentPasswordController,
                  hintText: "Current Password",
                  isPassword: true,
                ),
                Gap(26),
                CustomTextField(
                  controller: cubit.newPasswordController,
                  hintText: "New Password",
                  isPassword: true,
                ),
                Gap(26),
                CustomTextField(
                  controller: cubit.confirmPasswordController,
                  hintText: "Confirm Password",
                  isPassword: true,
                ),
                Gap(40),
                state is ProfileLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                      name: Text("Update Password", style: textStyle),
                      onTap: () {
                        cubit.updatePassword();
                      },
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
