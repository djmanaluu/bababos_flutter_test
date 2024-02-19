import 'package:bababos_test/app/app_router.dart';
import 'package:bababos_test/cart/cubits/cart_cubit.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/initial/initial_screen.dart';
import 'package:bababos_test/product_list/cubits/product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductListCubit()..loadProducts(),
        ),
        BlocProvider(
          create: (_) => CartCubit()..loadCartItems(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: BaseColors.darkGrey,
            elevation: 2.0,
            shadowColor: BaseColors.lightGrey,
          ),
        ),
        initialRoute: InitialScreen.routeName,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
