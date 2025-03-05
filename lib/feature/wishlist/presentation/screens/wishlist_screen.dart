import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/feature/wishlist/presentation/widgets/wishlist_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          'Wishlist',
          style: textStyle.copyWith(
            color: AppColor.dark,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return Center(child: Lottie.asset(AppAssets.loading));
            } else if (state is WishlistLoaded) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return WishlistCard(wishlist: state.items[index]);
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.items.length,
              );
            } else if (state is WishlistError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("No items in wishlist"));
          },
        ),
      ),
    );
  }
}
