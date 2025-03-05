import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/layout/presentation/screens/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SuccessAlert extends StatelessWidget {
  const SuccessAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(22.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssets.animation, height: 140, width: 140),
            Gap(24),
            Text(
              "SUCCESS!",
              style: textStyle.copyWith(
                fontSize: 36.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.dark,
              ),
            ),
            Gap(10),
            Text(
              "Your order will be delivered soon Thank you for choosing our app!",
              style: textStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.darkGrey,
              ),
            ),
            Gap(24),
            CustomButton(
              name: Text("Back To Home", style: textStyle),
              onTap: () {
                context.pushAndRemoveUntil(BottomNavigationBarCustom());
              },
            ),
          ],
        ),
      ),
    );
  }
}
