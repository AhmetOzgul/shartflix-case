import 'package:flutter/material.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;

  const RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.context,
  });
}

class RegisterPasswordVisibilityToggled extends RegisterEvent {}

class RegisterErrorCleared extends RegisterEvent {}

class RegisterSuccessCleared extends RegisterEvent {}
