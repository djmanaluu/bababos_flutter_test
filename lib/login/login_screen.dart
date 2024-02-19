import 'package:bababos_test/commons/ui/base_button.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:bababos_test/commons/ui/base_text_field.dart';
import 'package:bababos_test/initial/initial_screen.dart';
import 'package:bababos_test/login/cubits/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    final state = cubit.state;

    return BaseScaffold(
      isLoading: state.isLoading,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 24.0,
              right: 24.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50.0,
                  child: SvgPicture.asset("assets/images/big_logo.svg"),
                ),
                const SizedBox(height: 60.0),
                BaseTextField(
                  title: "Username",
                  placeholder: "Masukkan username kamu disini",
                  onValueChanged: (value) => cubit.changeUsername(value),
                ),
                const SizedBox(height: 16.0),
                BaseTextField(
                  title: "Password",
                  placeholder: "Masukkan password",
                  onValueChanged: (value) => cubit.changePassword(value),
                  isSecureText: true,
                ),
                const SizedBox(height: 32.0),
                BaseButton(
                  title: "Masuk",
                  isEnabled: state.isLoginButtonEnabled,
                  onTapped: () {
                    cubit.login(
                      onSuccess: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        InitialScreen.routeName,
                        (route) =>
                            route.settings.name == InitialScreen.routeName,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
