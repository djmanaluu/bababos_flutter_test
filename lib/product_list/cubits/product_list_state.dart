import 'package:bababos_test/commons/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductListState extends Equatable {
  final List<ProductModel> products;
  final bool isLoading;
  final String errorMessage;

  Map<int, ProductModel> get productMap {
    Map<int, ProductModel> prodMap = {};

    for (final product in products) {
      prodMap[product.id] = product;
    }

    return prodMap;
  }

  const ProductListState({
    this.products = const [],
    this.isLoading = true,
    this.errorMessage = "",
  });

  ProductListState copy({
    List<ProductModel>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, errorMessage];
}
