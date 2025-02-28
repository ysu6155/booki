import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/product.dart';
import 'package:booki/feature/home/presentation/screens/home/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardBook extends StatelessWidget {
  final Product book;

  const CardBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              book.image ?? "",
              height: 175,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Gap(6),
          Text(
            book.name ?? "",
            style: textStyle.copyWith(
              color: AppColor.dark,
              fontSize: 18,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${book.price ?? ""} EGP",
                style: textStyle.copyWith(
                  color: AppColor.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(12),
              CustomButton(
                backgroundColor: AppColor.dark,
                width: 80,
                height: 30,
                name: Text(
                  "Buy",
                  style: textStyle.copyWith(fontSize: 14),
                ),
                onTap: () {
                  // Handle Buy Action
                },
              ),
            ],
          ),
        ],
      ),
    ).withTapEffect(onTap: () {
      context.push(BookDetailsScreen(book:book));
    });
  }
}
