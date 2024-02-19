import 'package:bababos_test/cart/cubits/cart_cubit.dart';
import 'package:bababos_test/commons/ui/base_button.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:bababos_test/product_list/cubits/product_list_cubit.dart';
import 'package:bababos_test/success/success_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final Function() openProductList;

  const CartScreen({
    super.key,
    required this.openProductList,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final productsCubit = context.watch<ProductListCubit>();
    final productMap = productsCubit.state.productMap;

    double totalPrice = 0;

    for (final cartItem in cartCubit.state.cartItems) {
      final productModel = productMap[cartItem.productId];

      totalPrice += cartItem.qty * (productModel?.price ?? 0);
    }

    return BaseScaffold(
      isLoading: cartCubit.state.isLoading,
      body: cartCubit.state.cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: cartCubit.state.cartItems.length,
              padding: const EdgeInsets.all(24.0),
              itemBuilder: (_, index) {
                final cartModel = cartCubit.state.cartItems[index];
                final productModel = productMap[cartModel.productId];

                if (productModel == null) return const SizedBox();

                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  height: 64.0,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.0,
                        child:
                            CachedNetworkImage(imageUrl: productModel.imageUrl),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              productModel.title,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: BaseColors.darkGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "\$${productModel.price} / item",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: BaseColors.purple,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _generateChangeQuantityButton(
                                  icon: Icons.remove_circle,
                                  onTapped: () {
                                    if (cartModel.qty > 1) {
                                      cartCubit.updateQty(
                                        id: cartModel.id,
                                        qty: cartModel.qty - 1,
                                      );
                                    } else {
                                      _showConfirmToRemoveCartItem(
                                        context,
                                        id: cartModel.id,
                                        index: index,
                                        productTitle: productModel.title,
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  width: 40.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    cartModel.qty.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: BaseColors.darkGrey,
                                    ),
                                  ),
                                ),
                                _generateChangeQuantityButton(
                                  icon: Icons.add_circle,
                                  onTapped: () => cartCubit.updateQty(
                                    id: cartModel.id,
                                    qty: cartModel.qty + 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      InkWell(
                        onTap: () {
                          _showConfirmToRemoveCartItem(
                            context,
                            id: cartModel.id,
                            index: index,
                            productTitle: productModel.title,
                          );
                        },
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: BaseColors.red,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.not_interested_outlined,
                    size: 52.0,
                    color: BaseColors.red,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "No items added to cart, let's explore our product",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: BaseColors.darkGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: cartCubit.state.cartItems.isNotEmpty
          ? Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: BaseColors.lightGrey,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                color: BaseColors.darkGrey,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              "\$$totalPrice",
                              style: const TextStyle(
                                color: BaseColors.purple,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BaseButton(
                        title: "Purchase",
                        backgroundColor: BaseColors.purple,
                        onTapped: () async {
                          cartCubit.clearItems();

                          await Navigator.of(context).pushNamed(
                            SuccessScreen.routeName,
                          );

                          openProductList();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _generateChangeQuantityButton({
    required IconData icon,
    required Function() onTapped,
  }) {
    return InkWell(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          size: 20.0,
          color: BaseColors.purple,
        ),
      ),
    );
  }

  void _showConfirmToRemoveCartItem(
    BuildContext context, {
    required int id,
    required int index,
    required String productTitle,
  }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                "Are you sure to remove \"$productTitle\" from your cart?",
                style: const TextStyle(
                  color: BaseColors.darkGrey,
                  fontSize: 12.0,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.read<CartCubit>().removeItem(id: id);
                      Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: BaseColors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "No",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: BaseColors.darkGrey,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
