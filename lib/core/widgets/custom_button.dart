import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget name;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function() onTap;
  final Border? border;
  double? width;
  double? height;

  CustomButton(
      {super.key,
      required this.name,
      this.backgroundColor,
      this.textColor,
      required this.onTap,
      this.border,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: width ?? double.infinity,
      height: height ?? 48.sp,
      decoration: BoxDecoration(
        border: border ?? Border.all(color: AppColor.transparent, width: 2.sp),
        // gradient: backgroundColor ?? AppColor.primaryGradient,
        color: backgroundColor ?? AppColor.main,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(child: name),
    ).withTapEffect(onTap: onTap);
  }
}
