import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BaseScaffold extends StatelessWidget {
  final bool isLoading;
  final Widget? body;
  final AppBar? appBar;
  final Drawer? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const BaseScaffold({
    super.key,
    this.body,
    this.isLoading = false,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: appBar,
            backgroundColor: Colors.white,
            body: body,
            drawer: drawer,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
          ),
          if (isLoading)
            Container(
              color: BaseColors.darkBackground.withOpacity(0.5),
              child: Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
