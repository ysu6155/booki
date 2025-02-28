import 'package:booki/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';

Widget buildPage({required String image, required String title}) {
  return Column(
    children: [
      Image.asset(image),
      20.H,
      Text(title, style: textStyle.copyWith(color: AppColor.dark)),
    ],
  );
}
