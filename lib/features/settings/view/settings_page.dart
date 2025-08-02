import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import '../../../core/bloc/theme_bloc.dart';
import '../../../core/services/language_service.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentLanguage = 'tr';

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadSettings());
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final language = await LanguageService.getLanguage();
    setState(() {
      _currentLanguage = language;
    });
  }

  Future<void> _showLogoutDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.logout_title'.tr()),
        content: Text('profile.logout_message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('profile.logout_confirm'.tr()),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      context.read<SettingsBloc>().add(Logout());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded && state.isLoggedOut) {
          context.go(AppRoutes.login);
        }
        if (state is SettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<ThemeBloc, ThemeState>(
          listener: (context, themeState) {},
          builder: (context, themeState) {
            bool isDarkMode = true;

            if (themeState is ThemeLoaded) {
              isDarkMode = themeState.isDarkMode;
            }

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: theme.appBarTheme.backgroundColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.appBarTheme.foregroundColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'profile.settings'.tr(),
                  style: TextStyle(color: theme.appBarTheme.foregroundColor),
                ),
              ),
              body: state is SettingsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    )
                  : state is SettingsLoaded
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDropdownSettingItem(
                            icon: Icons.brightness_6,
                            title: 'profile.theme'.tr(),
                            value: isDarkMode ? 'dark' : 'light',
                            items: [
                              DropdownMenuItem(
                                value: 'light',
                                child: Text('profile.light_mode'.tr()),
                              ),
                              DropdownMenuItem(
                                value: 'dark',
                                child: Text('profile.dark_mode'.tr()),
                              ),
                            ],
                            onChanged: (value) async {
                              if (value != null) {
                                context.read<SettingsBloc>().add(ToggleTheme());

                                final newThemeMode = value == 'dark'
                                    ? ThemeMode.dark
                                    : ThemeMode.light;
                                context.read<ThemeBloc>().add(
                                  ChangeTheme(newThemeMode),
                                );
                              }
                            },
                            theme: theme,
                          ),
                          const SizedBox(height: 16),

                          _buildDropdownSettingItem(
                            icon: Icons.language,
                            title: 'profile.language'.tr(),
                            value: _currentLanguage,
                            items: [
                              DropdownMenuItem(
                                value: 'tr',
                                child: Text('profile.turkish'.tr()),
                              ),
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('profile.english'.tr()),
                              ),
                            ],
                            onChanged: (value) async {
                              if (value != null && value != _currentLanguage) {
                                context.read<SettingsBloc>().add(
                                  ChangeLanguage(value),
                                );

                                await LanguageService.setLanguage(value);
                                setState(() {
                                  _currentLanguage = value;
                                });

                                if (value == 'tr') {
                                  await context.setLocale(const Locale('tr'));
                                } else {
                                  await context.setLocale(
                                    const Locale('en', 'US'),
                                  );
                                }
                              }
                            },
                            theme: theme,
                          ),
                          const SizedBox(height: 32),

                          _buildSettingItem(
                            icon: Icons.logout,
                            title: 'profile.logout'.tr(),
                            subtitle: 'profile.logout_subtitle'.tr(),
                            onTap: _showLogoutDialog,
                            isDestructive: true,
                            theme: theme,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdownSettingItem({
    required IconData icon,
    required String title,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.textTheme.titleMedium?.color),
        title: Text(
          title,
          style: TextStyle(
            color: theme.textTheme.titleMedium?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          dropdownColor: theme.cardTheme.color,
          style: TextStyle(color: theme.textTheme.titleMedium?.color),
          underline: const SizedBox.shrink(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
    required ThemeData theme,
  }) {
    final textColor = isDestructive
        ? Colors.red
        : theme.textTheme.titleMedium?.color;
    final subtitleColor = isDestructive
        ? Colors.red[300]
        : theme.textTheme.bodySmall?.color;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: subtitleColor)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: theme.textTheme.bodySmall?.color,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
