import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/shared/themes/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/di/service_locator.dart';
import 'core/bloc/theme_bloc.dart';
import 'core/services/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await setupLocator();

  final savedLanguage = await LanguageService.getLanguage();
  final initialLocale = savedLanguage == 'tr'
      ? const Locale('tr')
      : const Locale('en', 'US');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      startLocale: initialLocale,
      child: BlocProvider(
        create: (context) => ThemeBloc()..add(LoadTheme()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        ThemeMode themeMode = ThemeMode.dark;

        if (state is ThemeLoaded) {
          themeMode = state.themeMode;
        }

        return MaterialApp.router(
          theme: AppTheme.lightTheme,
          themeMode: themeMode,
          darkTheme: AppTheme.darkTheme,
          title: 'app.title'.tr(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
