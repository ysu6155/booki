import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/feature/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:booki/feature/home/presentation/widgets/card_book.dart';
import 'package:booki/feature/home/presentation/widgets/home_baneer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getBestSellers(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          title: SvgPicture.asset(AppAssets.logoSVG, width: 100),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.search),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.notification),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is BestSellersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BestSellersResponse) {
              return ListView(
                children: [
                  BlocProvider(
                    create: (context) => HomeCubit(),
                    child: HomeBanner(),
                  ),
                  Gap(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(
                        color: AppColor.dark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: .6,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return CardBook(book: state.products[index]);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BestSellersError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
