import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:booki/feature/home/data/models/best_sellers_response/product.dart';
import 'package:booki/feature/wishlist/data/models/wishlist/datum.dart';
import 'package:booki/feature/wishlist/data/models/wishlist/wishlist.dart';
import 'package:booki/feature/wishlist/data/rebo/wishlist_rebo.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  Future<void> loadWishlist() async {
    emit(WishlistLoading());
    try {
      final items = await WishlistRepository.getWishlistItems();
      log(items.length.toString());
      emit(WishlistLoaded(items));
      log(items.toString());
    } catch (e) {
      emit(WishlistError(e.toString()));
      log(e.toString());
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      await WishlistRepository.addToWishlist(productId);
      loadWishlist();
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      await WishlistRepository.removeFromWishlist(productId);
      loadWishlist();
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
