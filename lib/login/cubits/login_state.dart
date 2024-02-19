part of './login_cubit.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isLoading;

  bool get isLoginButtonEnabled => username.isNotEmpty && password.isNotEmpty;

  const LoginState({
    this.username = "",
    this.password = "",
    this.isLoading = false,
  });

  LoginState copy({
    String? username,
    String? password,
    bool? isLoading,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [username, password, isLoading];
}
