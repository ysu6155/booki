import 'package:booki/feature/cart/data/models/cart/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  CartLoaded(this.items);
}

class CartUpdated extends CartState {
  final Map<int, int> itemQuantities;
  CartUpdated(this.itemQuantities);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartLimitExceeded extends CartState {
  final String message;
  CartLimitExceeded(this.message);
}
