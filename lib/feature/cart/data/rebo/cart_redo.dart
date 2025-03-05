import 'dart:convert';
import 'dart:developer';

import 'package:booki/core/network/dio_helper.dart';
import 'package:booki/core/network/end_points.dart';
import 'package:booki/core/service/local/shared_keys.dart';
import 'package:booki/core/service/local/shared_prefs_helper.dart';
import 'package:booki/feature/cart/data/models/cart/cart_item.dart';

class CartRepository {
  static var data;
  static Future<List<CartItem>> fetchCartItems() async {
    try {
      final response = await DioHelper.get(
        endPoints: EndPoints.cart,
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode == 200) {
        data = response.data["data"]["total"];
        final cartItems = response.data["data"]["cart_items"];

        if (cartItems is List) {
          return cartItems.map((item) => CartItem.fromJson(item)).toList();
        } else {
          throw Exception("Unexpected data format for cart items");
        }
      } else {
        throw Exception("Failed to load cart items");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<void> addToCart(int productId, int quantity) async {
    try {
      final response = await DioHelper.post(
        endPoints: EndPoints.addToCart,
        body: {"product_id": productId, "quantity": quantity},
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode == 201) {
        log("تمت إضافة المنتج بنجاح");
      } else {
        throw Exception("فشل في إضافة المنتج إلى السلة");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error: $e");
    }
  }

  static Future<Map<String, dynamic>> updateCartItemQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await DioHelper.post(
        endPoints: EndPoints.updateCart,
        body: {"quantity": quantity, "cart_item_id": cartItemId},
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode == 201) {
        data = response.data["data"]["total"];
        return response.data;
      } else {
        throw Exception("Failed to update cart item quantity");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error: $e");
    }
  }

  static Future<void> removeFromCartApi(int itemId) async {
    try {
      final response = await DioHelper.post(
        endPoints: EndPoints.removeFromCart,
        body: {"cart_item_id": itemId},
        headers: {
          "Authorization": "Bearer ${SharedHelper.get(SharedKeys.kToken)}",
        },
      );

      if (response.statusCode == 200) {
        data = response.data["data"]["total"];
        log("تم حذف المنتج بنجاح");
      } else {
        throw Exception("فشل في حذف المنتج من السلة");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error: $e");
    }
  }
}
