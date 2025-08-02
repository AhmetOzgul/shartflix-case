import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';
import 'routes.dart';

class AppRouter {
  static final UserService _userService = GetIt.instance<UserService>();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) async {
      final isLoggedIn = await _userService.isLoggedIn();
      final isSplashRoute = state.matchedLocation == AppRoutes.splash;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      final isRegisterRoute = state.matchedLocation == AppRoutes.register;

      if (isSplashRoute) {
        final prefs = await SharedPreferences.getInstance();
        final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

        if (isFirstLaunch) {
          return null;
        } else {
          if (isLoggedIn) {
            return AppRoutes.home;
          } else {
            return AppRoutes.login;
          }
        }
      }

      if (isLoggedIn && (isLoginRoute || isRegisterRoute)) {
        return AppRoutes.home;
      }

      if (!isLoggedIn && !isLoginRoute && !isRegisterRoute) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: AppRoutes.routes,

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'error.page_not_found'.tr(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.login),
              child: Text('common.back_to_home'.tr()),
            ),
          ],
        ),
      ),
    ),
  );
}
