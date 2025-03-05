import 'package:booki/core/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildPage({required String image, required String title}) {
  return Column(
    children: [
      SvgPicture.asset(image),
      20.H,
      Text(title, style: textStyle.copyWith(color: AppColor.dark)),
    ],
  );
}
