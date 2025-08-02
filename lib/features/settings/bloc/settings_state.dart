abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final String currentLanguage;
  final bool isLoggedOut;

  SettingsLoaded({
    required this.isDarkMode,
    required this.currentLanguage,
    this.isLoggedOut = false,
  });

  SettingsLoaded copyWith({
    bool? isDarkMode,
    String? currentLanguage,
    bool? isLoggedOut,
  }) {
    return SettingsLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}
