import 'dart:async';

import 'package:bababos_test/cart/cubits/cart_state.dart';
import 'package:bababos_test/cart/models/cart_db.dart';
import 'package:bababos_test/cart/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(cartItems: []));

  Future<void> loadCartItems() async {
    final savedCartItems = await CartDb.fetchAll();
    emit(state.copy(cartItems: savedCartItems));
  }

  Future<void> addItem({required int productId}) async {
    int? productCartId;
    int? oldQty;
    List<CartModel> cartItems = [];

    for (var i = 0; i < state.cartItems.length; i++) {
      if (state.cartItems[i].productId == productId) {
        productCartId = state.cartItems[i].id;
        oldQty = state.cartItems[i].qty;

        cartItems.add(
          state.cartItems[i].copy(qty: state.cartItems[i].qty + 1),
        );

        break;
      }

      cartItems.add(state.cartItems[i].copy());
    }

    int? newCartId;

    if (productCartId != null) {
      await CartDb.update(id: productCartId, qty: (oldQty ?? 0) + 1);
    } else {
      newCartId = await CartDb.insert(productId: productId);
    }

    emit(
      state.copy(
        cartItems: [
          if (newCartId != null)
            CartModel(
              id: newCartId,
              productId: productId,
              qty: 1,
            ),
          ...cartItems,
        ],
      ),
    );
  }

  Future<void> updateQty({
    required int id,
    required int qty,
  }) async {
    CartDb.update(id: id, qty: qty);

    // Deep copy object
    // Because if we just change the value by using index,
    // It will copy by reference
    List<CartModel> newCartItems = [];

    for (var i = 0; i < state.cartItems.length; i++) {
      final oldModel = state.cartItems[i];

      newCartItems.add(
        oldModel.copy(qty: oldModel.id == id ? qty : null),
      );
    }

    emit(state.copy(cartItems: newCartItems));
  }

  Future<void> removeItem({required int id}) async {
    CartDb.delete(id: id);

    // Deep copy object
    // Because if we just change the value by using index,
    // It will copy by reference
    List<CartModel> newCartItems = [];

    for (var i = 0; i < state.cartItems.length; i++) {
      final oldModel = state.cartItems[i];

      if (oldModel.id != id) {
        newCartItems.add(
          oldModel.copy(),
        );
      }
    }

    emit(state.copy(cartItems: newCartItems));
  }

  Future<void> clearItems() async {
    emit(state.copy(isLoading: true));

    Timer(
      const Duration(seconds: 1),
      () {
        emit(state.copy(
          isLoading: false,
          cartItems: [],
        ));
        CartDb.deleteAll();
      },
    );
  }
}
