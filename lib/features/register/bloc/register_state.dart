abstract class RegisterState {
  const RegisterState();

  bool get isPasswordVisible;
}

class RegisterInitial extends RegisterState {
  @override
  final bool isPasswordVisible;
  const RegisterInitial({this.isPasswordVisible = false});
}

class RegisterLoading extends RegisterState {
  @override
  final bool isPasswordVisible;
  const RegisterLoading({this.isPasswordVisible = false});
}

class RegisterSuccess extends RegisterState {
  final String message;
  @override
  final bool isPasswordVisible;
  const RegisterSuccess(this.message, {this.isPasswordVisible = false});
}

class RegisterError extends RegisterState {
  final String message;
  @override
  final bool isPasswordVisible;
  const RegisterError(this.message, {this.isPasswordVisible = false});
}
