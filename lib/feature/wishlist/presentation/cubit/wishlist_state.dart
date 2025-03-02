part of 'wishlist_cubit.dart';

abstract class WishlistState {
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Datum> items;

  WishlistLoaded(this.items);

  @override
  List<Object> get props => items;
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);

  @override
  List<Object> get props => [message];
}
