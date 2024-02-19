import 'package:bababos_test/cart/cubits/cart_cubit.dart';
import 'package:bababos_test/commons/ui/base_button.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/commons/utils/shared_preference_util.dart';
import 'package:bababos_test/initial/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32.0,
        left: 24.0,
        right: 24.0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Toko Kelontong Mak Ijah",
            style: TextStyle(
              color: BaseColors.darkGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Jalan Belawai Timur, Gg Ahmad Kadir, No 74, Jakarta Timur",
          ),
          const SizedBox(height: 16.0),
          const Text(
            "+62 8812 2434 4432",
          ),
          const Expanded(child: SizedBox()),
          BaseButton(
            title: "Log Out",
            backgroundColor: BaseColors.red,
            textColor: Colors.white,
            onTapped: () async {
              SharedPreferencesUtil.removeString(
                key: SharedPreferencesUtil.kUserName,
              );

              context.read<CartCubit>().clearItems().then(
                    (_) => Navigator.of(context).pushNamedAndRemoveUntil(
                      InitialScreen.routeName,
                      (route) => route.settings.name == InitialScreen.routeName,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
