import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/services/user_service.dart';
import '../../../core/services/theme_service.dart';
import '../../../core/services/language_service.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserService _userService = GetIt.instance<UserService>();

  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeLanguage>(_onChangeLanguage);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    try {
      final themeMode = await ThemeService.getThemeMode();
      final isDarkMode = ThemeService.isDarkMode(themeMode);

      final currentLanguage = await LanguageService.getLanguage();

      emit(
        SettingsLoaded(
          isDarkMode: isDarkMode,
          currentLanguage: currentLanguage,
        ),
      );
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newIsDarkMode = !currentState.isDarkMode;

      final newThemeMode = newIsDarkMode ? ThemeMode.dark : ThemeMode.light;
      await ThemeService.setThemeMode(newThemeMode);

      emit(currentState.copyWith(isDarkMode: newIsDarkMode));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;

      await LanguageService.setLanguage(event.language);

      emit(currentState.copyWith(currentLanguage: event.language));
    }
  }

  Future<void> _onLogout(Logout event, Emitter<SettingsState> emit) async {
    try {
      await _userService.logout();
      if (state is SettingsLoaded) {
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(isLoggedOut: true));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
