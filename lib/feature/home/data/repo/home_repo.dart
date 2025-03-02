import 'dart:developer';

import 'package:booki/core/network/dio_helper.dart';
import 'package:booki/core/network/end_points.dart';
import 'package:booki/feature/home/data/models/banner/slider.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/best_sellers_response.dart';

class HomeRepo {
  static Future<BestSellersResponse?> fetchBookDetails(int bookId) async {
    try {
      final response = await DioHelper.get(
        endPoints: EndPoints.productsBestseller,
      );
      if (response.statusCode == 200) {
        return BestSellersResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to load book details");
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  static Future<BestSellersResponse?> getBestSellers() async {
    try {
      var response = await DioHelper.get(
        endPoints: EndPoints.productsBestseller,
      );
      if (response.statusCode == 200) {
        return BestSellersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<Slider>?> getSliders() async {
    try {
      var response = await DioHelper.get(endPoints: EndPoints.sliders);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"]["sliders"];
        return data.map((e) => Slider.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
