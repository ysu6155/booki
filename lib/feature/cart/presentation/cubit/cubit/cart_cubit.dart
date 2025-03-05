import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:booki/feature/cart/data/models/cart/cart_item.dart';
import 'package:booki/feature/cart/data/rebo/cart_redo.dart';
import 'package:booki/feature/cart/presentation/cubit/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  Map<int, int> itemQuantities = {};
  double totalPrice = 0.0;
  CartCubit() : super(CartInitial());

  void loadCart() async {
    emit(CartLoading());
    try {
      final items = await CartRepository.fetchCartItems();

      log(items.length.toString());

      itemQuantities = {
        for (var item in items) item.itemId!: item.itemQuantity!,
      };

      log(items.length.toString());
      emit(CartLoaded(items));
    } catch (e) {
      log(e.toString());
      emit(CartError("Failed to load cart items"));
    }
  }

  void addProductToCart(int productId) async {
    try {
      await CartRepository.addToCart(productId, 1);

      loadCart();
    } catch (e) {
      emit(CartError("فشل في إضافة المنتج إلى السلة"));
    }
  }

  Future<void> updateQuantity(int cartItemId, int newQuantity) async {
    if (state is CartLoaded) {
      try {
        final response = await CartRepository.updateCartItemQuantity(
          cartItemId: cartItemId,
          quantity: newQuantity,
        );

        if (response["status"] != 200) {
          loadCart();
        }
      } catch (e) {
        emit(CartError("Error: ${e.toString()}"));
      }
    }
  }

  void removeFromCart(int itemId) async {
    if (state is CartLoaded) {
      try {
        await CartRepository.removeFromCartApi(itemId); // 🛠 تحديث الـ API
        loadCart();
      } catch (e) {
        emit(CartError("Failed to remove item"));
      }
    }
  }
}
