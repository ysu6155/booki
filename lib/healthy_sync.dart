import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/feature/welcome/presentation/screens/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthySync extends StatelessWidget {
  const HealthySync({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              // darkTheme: darkTheme,
              theme: themeLight,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'Healthy Sync',
              home: child);
        },
        child: SplashScreen());
  }
}
