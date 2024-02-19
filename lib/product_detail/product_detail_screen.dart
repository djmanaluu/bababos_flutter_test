import 'package:bababos_test/cart/cubits/cart_cubit.dart';
import 'package:bababos_test/commons/models/product_model.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailArgs {
  final ProductModel model;

  const ProductDetailArgs({required this.model});
}

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/products/detail";

  final ProductDetailArgs args;

  const ProductDetailScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CartCubit>();
    final productCartModel = cubit.state.cartItems
        .where(
          (model) => model.productId == args.model.id,
        )
        .toList();
    final isProductCartExist = productCartModel.isNotEmpty;

    return BaseScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 72.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: args.model.imageUrl,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                          imageUrl: args.model.imageUrl,
                          placeholder: (_, __) {
                            return LoadingAnimationWidget.threeRotatingDots(
                              color: BaseColors.darkGrey,
                              size: 24.0,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      args.model.title,
                      style: const TextStyle(
                        color: BaseColors.darkGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "\$${args.model.price}",
                      style: const TextStyle(
                        color: BaseColors.purple,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      args.model.category,
                      style: const TextStyle(
                        color: BaseColors.mediumBlue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      args.model.description,
                      style: const TextStyle(
                        color: BaseColors.textGrey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundColor: BaseColors.darkBackground.withOpacity(0.5),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => context.read<CartCubit>().addItem(
              productId: args.model.id,
            ),
        child: Stack(
          children: [
            const CircleAvatar(
              radius: 24.0,
              backgroundColor: BaseColors.purple,
              child: Icon(
                Icons.shopping_cart,
                size: 24.0,
                color: BaseColors.lightPurple,
              ),
            ),
            if (isProductCartExist)
              Positioned(
                top: 0.0,
                right: 0.0,
                child: CircleAvatar(
                  backgroundColor: BaseColors.red,
                  radius: 8.0,
                  child: Text(
                    productCartModel.first.qty.toString(),
                    style: const TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
