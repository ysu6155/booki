import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:booki/feature/home/data/repo/home_repo.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getBestSellers() async {
    emit(BestSellersLoading());

    try {
      final response = await HomeRepo.getBestSellers();

      if (response != null && response.data != null) {
        List<Product> books = response.data?.products ?? [];
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
      // log("Response Data: $response");
      if (response != null) {
        List<String> sliderImages =
            response.map((slider) => slider.image ?? "").toList();

        //log("Slider Images: $sliderImages");
        emit(SlidersSuccess(sliderImages));
      } else {
        emit(SlidersError("No sliders available"));
      }
    } catch (e) {
      emit(SlidersError("Failed to load sliders: $e"));
    }
  }
}
