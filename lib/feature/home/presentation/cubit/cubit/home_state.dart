part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class BestSellersLoading extends HomeState {}

@override
List<Object> get props => [];

class BestSellersInitial extends HomeState {}

class BestSellersResponse extends HomeState {
  final List<Product> products;

  BestSellersResponse({required this.products});

  factory BestSellersResponse.fromJson(Map<String, dynamic> json) {
    return BestSellersResponse(
      products:
          (json['data']['products'] as List)
              .map((e) => Product.fromJson(e))
              .toList(),
    );
  }
}

class BestSellersError extends HomeState {
  final String message;
  BestSellersError(this.message);
}

// Sliders States
class SlidersLoading extends HomeState {}

class SlidersSuccess extends HomeState {
  final List<String?> sliders;
  SlidersSuccess(this.sliders);
}

class SlidersError extends HomeState {
  final String message;
  SlidersError(this.message);
}
