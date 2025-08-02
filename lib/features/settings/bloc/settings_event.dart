abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final String language;
  ChangeLanguage(this.language);
}

class Logout extends SettingsEvent {}
