import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/widgets/custom_button.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BookDetailsScreen extends StatelessWidget {
  final Product book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name ?? ""),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(book.image ?? "", height: 200),
              ),
              Gap(16),
              Text(book.name ?? "",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("${book.description}",
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              Gap(10),
              Text("${book.price ?? ""} EGP",
                  style: textStyle.copyWith(
                      fontSize: 16.sp, color: AppColor.dark)),
              Gap(15),
              CustomButton(
                onTap: () {},
                name: Text(
                  "Buy Now",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
