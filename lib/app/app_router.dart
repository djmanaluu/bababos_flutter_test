import 'package:bababos_test/initial/initial_screen.dart';
import 'package:bababos_test/product_detail/product_detail_screen.dart';
import 'package:bababos_test/success/success_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static RouteObserver routeObserver = RouteObserver();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case InitialScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const InitialScreen(),
        );
      case ProductDetailScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            args: args as ProductDetailArgs,
          ),
        );
      case SuccessScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SuccessScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }
}
