import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/user_service.dart';
import '../../../core/services/network_service.dart';
import '../../../core/router/routes.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService _userService = getIt<UserService>();

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  RegisterBloc() : super(RegisterInitial(isPasswordVisible: false)) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<RegisterErrorCleared>(_onErrorCleared);
    on<RegisterSuccessCleared>(_onSuccessCleared);
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading(isPasswordVisible: _isPasswordVisible));

    try {
      final response = await _userService.register(
        name: event.name.trim(),
        email: event.email.trim(),
        password: event.password,
      );

      if (response.response.code == 200) {
        emit(
          RegisterSuccess(
            'register.success'.tr(),
            isPasswordVisible: _isPasswordVisible,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (event.context.mounted) {
          event.context.go(AppRoutes.uploadPhoto);
        }
      } else {
        final responseMessage = response.response.message;

        final errorMessage = response.response.code == 500
            ? (responseMessage.isNotEmpty
                  ? responseMessage
                  : 'error.server_error'.tr())
            : responseMessage == 'USER_EXISTS'
            ? 'register.user_exists'.tr()
            : 'register.invalid_credentials'.tr();

        emit(
          RegisterError(errorMessage, isPasswordVisible: _isPasswordVisible),
        );
      }
    } on BadRequestException catch (e) {
      if (e.message.contains('USER_EXISTS')) {
        emit(
          RegisterError(
            'register.user_exists'.tr(),
            isPasswordVisible: _isPasswordVisible,
          ),
        );
      } else {
        emit(
          RegisterError(
            'register.invalid_credentials'.tr(),
            isPasswordVisible: _isPasswordVisible,
          ),
        );
      }
    } on NetworkException catch (e) {
      emit(RegisterError(e.message, isPasswordVisible: _isPasswordVisible));
    } catch (e) {
      emit(
        RegisterError(
          'error.unknown_error'.tr(args: ['$e']),
          isPasswordVisible: _isPasswordVisible,
        ),
      );
    }
  }

  void _onPasswordVisibilityToggled(
    RegisterPasswordVisibilityToggled event,
    Emitter<RegisterState> emit,
  ) {
    _isPasswordVisible = !_isPasswordVisible;
    emit(RegisterInitial(isPasswordVisible: _isPasswordVisible));
  }

  void _onErrorCleared(
    RegisterErrorCleared event,
    Emitter<RegisterState> emit,
  ) {
    if (state is RegisterError) {
      emit(RegisterInitial(isPasswordVisible: _isPasswordVisible));
    }
  }

  void _onSuccessCleared(
    RegisterSuccessCleared event,
    Emitter<RegisterState> emit,
  ) {
    if (state is RegisterSuccess) {
      emit(RegisterInitial(isPasswordVisible: _isPasswordVisible));
    }
  }

  void togglePasswordVisibility() {
    add(RegisterPasswordVisibilityToggled());
  }

  void register(
    BuildContext context,
    String name,
    String email,
    String password,
  ) {
    add(
      RegisterSubmitted(
        name: name,
        email: email,
        password: password,
        context: context,
      ),
    );
  }
}
