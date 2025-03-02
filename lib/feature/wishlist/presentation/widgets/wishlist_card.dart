import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:booki/feature/wishlist/data/models/wishlist/datum.dart';
import 'package:booki/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WishlistCard extends StatelessWidget {
  final Datum wishlist;

  const WishlistCard({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.network(
            wishlist.image ?? "",
            height: 120.sp,
            width: 100.sp,
            fit: BoxFit.cover,
          ),
        ),
        Gap(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wishlist.name ?? "",
                          style: textStyle.copyWith(
                            color: AppColor.dark,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                        Gap(8),
                        Text(
                          "₹${wishlist.price}",
                          style: textStyle.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      bool isInWishlist = false;

                      if (state is WishlistLoaded) {
                        isInWishlist = state.items.any(
                          (item) => item.id == wishlist.id,
                        );
                      }

                      return IconButton(
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: AppColor.main,
                        ),
                        onPressed: () {
                          if (isInWishlist) {
                            context.read<WishlistCubit>().removeFromWishlist(
                              wishlist.id ?? 0,
                            );
                          } else {
                            context.read<WishlistCubit>().addToWishlist(
                              wishlist.id ?? 0,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              Gap(30),
              CustomButton(
                height: 40.sp,
                name: Text(
                  "Add to Cart",
                  style: textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  context.read<CartCubit>().addProductToCart(wishlist.id ?? 0);
                },
              ),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 16.sp);
  }
}
