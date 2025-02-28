import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.darkGrey,
  inputDecorationTheme: inputDecorationTheme(
    AppColor.darkGrey,
    AppColor.white,
  ),
);
