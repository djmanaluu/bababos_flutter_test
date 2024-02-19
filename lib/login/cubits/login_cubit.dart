import 'dart:async';

import 'package:bababos_test/commons/utils/shared_preference_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void changeUsername(String username) {
    emit(state.copy(username: username));
  }

  void changePassword(String password) {
    emit(state.copy(password: password));
  }

  void login({
    required Function() onSuccess,
  }) {
    emit(state.copy(isLoading: true));

    Timer(const Duration(seconds: 2), () async {
      onSuccess();

      await SharedPreferencesUtil.setString(
        key: SharedPreferencesUtil.kUserName,
        value: state.username,
      );

      emit(state.copy(isLoading: false));
    });
  }
}
