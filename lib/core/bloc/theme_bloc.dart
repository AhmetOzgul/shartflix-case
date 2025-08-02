import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/theme_service.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final ThemeMode themeMode;

  const ChangeTheme(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  const ThemeLoaded({required this.themeMode, required this.isDarkMode});

  @override
  List<Object?> get props => [themeMode, isDarkMode];

  ThemeLoaded copyWith({ThemeMode? themeMode, bool? isDarkMode}) {
    return ThemeLoaded(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class ThemeError extends ThemeState {
  final String message;

  const ThemeError(this.message);

  @override
  List<Object?> get props => [message];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeLoading());
    try {
      final themeMode = await ThemeService.getThemeMode();
      final isDarkMode = ThemeService.isDarkMode(themeMode);
      emit(ThemeLoaded(themeMode: themeMode, isDarkMode: isDarkMode));
    } catch (e) {
      emit(ThemeError(e.toString()));
    }
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      await ThemeService.setThemeMode(event.themeMode);
      final isDarkMode = ThemeService.isDarkMode(event.themeMode);
      emit(ThemeLoaded(themeMode: event.themeMode, isDarkMode: isDarkMode));
    } catch (e) {
      emit(ThemeError(e.toString()));
    }
  }
}
