import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction; // إضافة تحكم في زر "تم"
  final ValueChanged<String>? onFieldSubmitted; // إضافة تحكم عند الضغط على "تم"

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.validator,
    this.floatingLabelBehavior,
    this.labelText,
    this.labelStyle,
    this.textInputAction = TextInputAction.done, // القيمة الافتراضية
    this.onFieldSubmitted, // دالة عند الضغط على "تم"
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      textInputAction: textInputAction, // تحديد نوع الإجراء
      onFieldSubmitted: onFieldSubmitted, // دالة عند الضغط على "تم"
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: labelText,
        labelStyle: labelStyle ??
            textStyle.copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
        hintStyle: textStyle.copyWith(
          color: AppColor.darkGrey,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                icon: SvgPicture.asset(AppAssets.eyaSVG, width: 20.sp),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
      style: textStyle.copyWith(fontSize: 16.sp, color: AppColor.black),
      validator: validator,
    );
  }
}
