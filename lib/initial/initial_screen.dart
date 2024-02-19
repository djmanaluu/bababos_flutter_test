import 'package:bababos_test/app/app_router.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:bababos_test/commons/utils/shared_preference_util.dart';
import 'package:bababos_test/home/home_screen.dart';
import 'package:bababos_test/login/cubits/login_cubit.dart';
import 'package:bababos_test/login/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InitialScreenType { login, home, loading }

class InitialScreen extends StatefulWidget {
  static const routeName = "/";
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with RouteAware {
  InitialScreenType _activeScreenType = InitialScreenType.loading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouter.routeObserver.subscribe(
      this,
      ModalRoute.of(context) as PageRoute,
    );
  }

  @override
  void dispose() {
    AppRouter.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SharedPreferencesUtil.getString(
      key: SharedPreferencesUtil.kUserName,
    ).then((value) {
      setState(() {
        _activeScreenType =
            value == null ? InitialScreenType.login : InitialScreenType.home;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_activeScreenType) {
      case InitialScreenType.loading:
        return const BaseScaffold(isLoading: true);
      case InitialScreenType.login:
        return BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        );
      case InitialScreenType.home:
        return const HomeScreen();
    }
  }
}
