import 'package:booki/feature/Cart/presentation/screens/cart_screen.dart';
import 'package:booki/feature/home/presentation/screens/home/home_screen.dart';
import 'package:booki/feature/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/feature/profile/presentation/screens/profile_screen.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  BottomNavigationBarCustomState createState() =>
      BottomNavigationBarCustomState();
}

class BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      WishlistScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColor.white),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.main,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.homeIcon, height: 25.sp),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.bookmark, height: 25.sp),
              label: "",
            ),
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(AppAssets.category, height: 25.sp),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset(AppAssets.profile, height: 25.sp),
            ),
          ],
        ),
      ),
    );
  }
}
