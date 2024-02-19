import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:bababos_test/product_detail/product_detail_screen.dart';
import 'package:bababos_test/product_list/cubits/product_list_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProductListCubit>();
    final state = cubit.state;
    final screenWidth = MediaQuery.of(context).size.width;

    final cellWidth = (screenWidth - 96.0) / 3.0;
    final cellHeight = cellWidth + 12.0 + 16.0 + 4.0 + 16.0;

    return BaseScaffold(
      isLoading: state.isLoading,
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: cellWidth / cellHeight,
        ),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final model = state.products[index];

          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: ProductDetailArgs(model: model),
            ),
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: model.imageUrl,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      placeholder: (_, __) {
                        return LoadingAnimationWidget.threeRotatingDots(
                          color: BaseColors.darkGrey,
                          size: 24.0,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: BaseColors.darkGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "\$${model.price}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: BaseColors.purple,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
