import 'package:booki/core/utils/app_color.dart';
import 'package:booki/feature/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchSliders(); // استدعاء الـ API عند فتح الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is SlidersLoading) {
          return const Center(child: CircularProgressIndicator()); // مؤشر تحميل
        } else if (state is SlidersError) {
          return Center(child: Text(state.message)); // رسالة خطأ لو الـ API فشل
        } else if (state is SlidersSuccess) {
          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: state.sliders.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      state.sliders[index] ?? "", // تحميل الصور من API
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 160,
                  viewportFraction: .85,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: state.sliders.length,
                effect: ExpandingDotsEffect(
                  expansionFactor: 3,
                  activeDotColor: AppColor.main,
                  dotColor: AppColor.secondary.withOpacity(0.5),
                  dotHeight: 10,
                  dotWidth: 15,
                  spacing: 6,
                ),
                onDotClicked: (index) {
                  _carouselController.animateToPage(index);
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink(); // في حالة لم يكن هناك بيانات
      },
    );
  }
}
