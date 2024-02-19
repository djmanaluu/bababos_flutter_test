import 'package:bababos_test/cart/models/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartModel> cartItems;
  final bool isLoading;

  const CartState({
    required this.cartItems,
    this.isLoading = false,
  });

  CartState copy({
    bool? isLoading,
    List<CartModel>? cartItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        cartItems,
        isLoading,
      ];
}
