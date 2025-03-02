import 'package:booki/core/network/dio_helper.dart';
import 'package:booki/core/network/end_points.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';
import 'package:booki/feature/wishlist/data/models/wishlist/datum.dart';

class WishlistRepository {
  static Future<List<Datum>> getWishlistItems() async {
    try {
      final response = await DioHelper.get(
        endPoints: EndPoints.wishlist,
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['data']['data'];

        return items
            .map((item) => Datum.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wishlist: $e');
    }
  }

  static Future<void> addToWishlist(int productId) async {
    try {
      final response = await DioHelper.post(
        endPoints: EndPoints.addToWishlist,
        body: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to add product to wishlist");
      }
    } catch (e) {
      throw Exception("Error adding product to wishlist: $e");
    }
  }

  static Future<void> removeFromWishlist(int productId) async {
    try {
      final response = await DioHelper.post(
        endPoints: EndPoints.removeFromWishlist,
        body: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to remove product from wishlist");
      }
    } catch (e) {
      throw Exception("Error removing product from wishlist: $e");
    }
  }
}
