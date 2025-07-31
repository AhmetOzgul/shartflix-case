import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/user_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/router/routes.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService _userService = getIt<UserService>();

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  LoginBloc() : super(LoginInitial(isPasswordVisible: false)) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginErrorCleared>(_onErrorCleared);
    on<LoginSuccessCleared>(_onSuccessCleared);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading(isPasswordVisible: _isPasswordVisible));

    try {
      final response = await _userService.login(
        email: event.email.trim(),
        password: event.password,
      );

      if (response.response.code == 200) {
        emit(
          LoginSuccess(
            'login.success'.tr(),
            isPasswordVisible: _isPasswordVisible,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (event.context.mounted) {
          event.context.go(AppRoutes.uploadPhoto);
        }
      } else {
        final errorMessage = response.response.code == 500
            ? (response.response.message.isNotEmpty
                  ? response.response.message
                  : 'error.server_error'.tr())
            : 'login.invalid_credentials'.tr();

        emit(LoginError(errorMessage, isPasswordVisible: _isPasswordVisible));
      }
    } on BadRequestException {
      emit(
        LoginError(
          'login.invalid_credentials'.tr(),
          isPasswordVisible: _isPasswordVisible,
        ),
      );
    } on NetworkException catch (e) {
      emit(LoginError(e.message, isPasswordVisible: _isPasswordVisible));
    } catch (e) {
      emit(
        LoginError(
          'error.unknown_error'.tr(args: ['$e']),
          isPasswordVisible: _isPasswordVisible,
        ),
      );
    }
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    _isPasswordVisible = !_isPasswordVisible;
    emit(LoginInitial(isPasswordVisible: _isPasswordVisible));
  }

  void _onErrorCleared(LoginErrorCleared event, Emitter<LoginState> emit) {
    if (state is LoginError) {
      emit(LoginInitial(isPasswordVisible: _isPasswordVisible));
    }
  }

  void _onSuccessCleared(LoginSuccessCleared event, Emitter<LoginState> emit) {
    if (state is LoginSuccess) {
      emit(LoginInitial(isPasswordVisible: _isPasswordVisible));
    }
  }

  void togglePasswordVisibility() {
    add(LoginPasswordVisibilityToggled());
  }

  void login(BuildContext context, String email, String password) {
    add(LoginSubmitted(email: email, password: password, context: context));
  }
}
