import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/feature/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:booki/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:booki/feature/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:booki/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:booki/feature/welcome/presentation/screens/splash/splash_screen.dart';
import 'package:booki/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthySync extends StatelessWidget {
  const HealthySync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()..getProfileData()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()..getBestSellers()),
        BlocProvider(create: (context) => WishlistCubit()..loadWishlist()),
        BlocProvider(create: (context) => CartCubit()..loadCart()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: themeLight,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Healthy Sync',
            home: child,
          );
        },
        child: SplashScreen(),
      ),
    );
  }
}
