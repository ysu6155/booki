import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:booki/core/network/dio_helper.dart';
import 'package:booki/core/network/end_points.dart';
import 'package:booki/feature/home/data/repo/home_repo.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/best_sellers_response.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getBestSellers() async {
    emit(BestSellersLoading());

    try {
      final response = await HomeRepo.getBestSellers();

      if (response != null && response.data != null) {
        // ✅ تأكد إن الـ response مش null
        List<Product> books =
            response?.data?.products ?? []; // ✅ تعديل طريقة جلب الكتب
        emit(BestSellersResponse(products: books));
      } else {
        emit(BestSellersError("Failed to fetch best sellers"));
      }
    } catch (e) {
      log("❌ Error fetching sliders: $e");
      emit(BestSellersError(e.toString()));
    }
  }

  Future<void> fetchSliders() async {
    emit(SlidersLoading());
    try {
      final response = await HomeRepo.getSliders();
      print("Response Data: $response"); // ✅ اطبع البيانات واتأكد إنها مش فاضية

      if (response != null) {
        List<String> sliderImages =
            response.map((slider) => slider.image ?? "").toList();

        print("Slider Images: $sliderImages"); // ✅ اطبع قائمة الصور

        emit(SlidersSuccess(sliderImages));
      } else {
        emit(SlidersError("No sliders available"));
      }
    } catch (e) {
      emit(SlidersError("Failed to load sliders: $e"));
    }
  }
}
