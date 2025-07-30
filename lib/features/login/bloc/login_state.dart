abstract class LoginState {
  const LoginState();

  bool get isPasswordVisible;
}

class LoginInitial extends LoginState {
  @override
  final bool isPasswordVisible;
  const LoginInitial({this.isPasswordVisible = false});
}

class LoginLoading extends LoginState {
  @override
  final bool isPasswordVisible;
  const LoginLoading({this.isPasswordVisible = false});
}

class LoginSuccess extends LoginState {
  final String message;
  @override
  final bool isPasswordVisible;
  const LoginSuccess(this.message, {this.isPasswordVisible = false});
}

class LoginError extends LoginState {
  final String message;
  @override
  final bool isPasswordVisible;
  const LoginError(this.message, {this.isPasswordVisible = false});
}
