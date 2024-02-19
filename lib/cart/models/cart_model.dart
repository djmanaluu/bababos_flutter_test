import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final int productId;
  final int qty;

  const CartModel({
    required this.id,
    required this.productId,
    required this.qty,
  });

  CartModel copy({int? qty}) {
    return CartModel(id: id, productId: productId, qty: qty ?? this.qty);
  }

  CartModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        productId = json["product_id"],
        qty = json["qty"];

  @override
  List<Object?> get props => [id, productId, qty];
}
