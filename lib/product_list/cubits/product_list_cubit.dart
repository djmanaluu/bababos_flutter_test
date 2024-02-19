import 'package:bababos_test/commons/models/product_model.dart';
import 'package:bababos_test/commons/services/api_service.dart';
import 'package:bababos_test/product_list/cubits/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(const ProductListState());

  void loadProducts() {
    emit(state.copy(isLoading: true));

    APIService.fetch(
      "https://fakestoreapi.com/products/",
      onSuccess: (response) {
        final products = (response as List)
            .map(
              (json) => ProductModel.fromJson(json),
            )
            .toList();

        emit(state.copy(products: products, isLoading: false));
      },
      onFailure: (errorMessage) {
        emit(state.copy(errorMessage: errorMessage, isLoading: false));
      },
    );
  }
}
