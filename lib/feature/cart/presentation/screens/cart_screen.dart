import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/cart/data/models/cart/cart_item.dart';
import 'package:booki/feature/cart/data/rebo/cart_redo.dart';
import 'package:booki/feature/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:booki/feature/cart/presentation/cubit/cubit/cart_state.dart';
import 'package:booki/feature/cart/presentation/widgets/success_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: AppColor.dark,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartLimitExceeded) {
              ScaffoldMessenger.of(context1).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
            }
          },
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CartLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final cartItem = state.items[index];
                          return newMethod(cartItem);
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.items.length,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Total:",
                          style: textStyle.copyWith(color: AppColor.dark),
                        ),
                        Spacer(),
                        Text(
                          "${CartRepository.data} EGP",
                          style: textStyle.copyWith(color: AppColor.dark),
                        ),
                      ],
                    ),
                    Gap(20),
                    CustomButton(
                      name: Text("Checkout", style: textStyle),
                      onTap: () {
                        context.push(SuccessAlert());
                      },
                    ),
                    Gap(15),
                  ],
                );
              } else if (state is CartError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text("No items in cart"));
            },
          ),
        ),
      ),
    );
  }

  BlocBuilder<CartCubit, CartState> newMethod(CartItem cartItem) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int quantity = cartItem.itemQuantity ?? 0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                cartItem.itemProductImage ?? "",
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
                              cartItem.itemProductName ?? "",
                              style: textStyle.copyWith(
                                color: AppColor.dark,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                            ),
                            Gap(4),
                            Text(
                              "${cartItem.itemProductPrice} EGP",

                              style: textStyle.copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.sp,
                                color: AppColor.grey,
                              ),
                            ),
                            Gap(4),
                            Text(
                              "${cartItem.itemProductDiscount} %  Discount",
                              style: textStyle.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.red,
                              ),
                            ),
                            Gap(4),
                            Text(
                              "${cartItem.itemProductPriceAfterDiscount} EGP",
                              style: textStyle.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(30),
                  Row(
                    children: [
                      CustomButton(
                        height: 30.sp,
                        width: 30.sp,
                        backgroundColor: AppColor.darkGrey,
                        name: Icon(Icons.remove, color: AppColor.white),
                        onTap: () {
                          if (quantity > 1) {
                            context.read<CartCubit>().updateQuantity(
                              cartItem.itemId ?? 0,
                              (quantity - 1),
                            );
                          }
                        },
                      ),
                      Gap(15),
                      Text(quantity.toString()),
                      Gap(15),
                      CustomButton(
                        height: 30.sp,
                        width: 30.sp,
                        backgroundColor: AppColor.darkGrey,
                        name: Icon(Icons.add, color: AppColor.white),
                        onTap: () {
                          context.read<CartCubit>().updateQuantity(
                            cartItem.itemId ?? 0,
                            quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>().removeFromCart(cartItem.itemId ?? 0);
              },
              icon: SvgPicture.asset(AppAssets.shape),
            ),
          ],
        ).paddingSymmetric(vertical: 16.sp);
      },
    );
  }
}
