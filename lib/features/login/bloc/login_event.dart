import 'package:flutter/material.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginSubmitted({
    required this.email,
    required this.password,
    required this.context,
  });
}

class LoginPasswordVisibilityToggled extends LoginEvent {}

class LoginErrorCleared extends LoginEvent {}

class LoginSuccessCleared extends LoginEvent {}
