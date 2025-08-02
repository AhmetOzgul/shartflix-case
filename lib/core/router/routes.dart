import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/login/view/login_page.dart';
import '../../features/register/view/register_page.dart';
import '../../features/profile/view/upload_photo_page.dart';
import '../../features/home/view/main_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../features/settings/bloc/settings_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String uploadPhoto = '/upload-photo';
  static const String settings = '/settings';

  static const String loginName = 'login';
  static const String registerName = 'register';
  static const String homeName = 'home';
  static const String profileName = 'profile';
  static const String uploadPhotoName = 'upload-photo';
  static const String settingsName = 'settings';

  static Page<dynamic> _buildPageWithTransition(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Page<dynamic> _buildPageWithFadeTransition(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  static final List<RouteBase> routes = [
    GoRoute(
      path: login,
      name: loginName,
      pageBuilder: (context, state) =>
          _buildPageWithFadeTransition(const LoginPage(), state),
    ),
    GoRoute(
      path: register,
      name: registerName,
      pageBuilder: (context, state) =>
          _buildPageWithFadeTransition(const RegisterPage(), state),
    ),
    GoRoute(
      path: home,
      name: homeName,
      pageBuilder: (context, state) =>
          _buildPageWithTransition(const MainPage(), state),
    ),
    GoRoute(
      path: settings,
      name: settingsName,
      pageBuilder: (context, state) => _buildPageWithTransition(
        BlocProvider(
          create: (context) => SettingsBloc(),
          child: const SettingsPage(),
        ),
        state,
      ),
    ),
    GoRoute(
      path: uploadPhoto,
      name: uploadPhotoName,
      pageBuilder: (context, state) {
        final fromProfile = state.extra as Map<String, dynamic>?;
        final isFromProfile = fromProfile?['fromProfile'] ?? false;
        return _buildPageWithTransition(
          UploadPhotoPage(fromProfile: isFromProfile),
          state,
        );
      },
    ),
  ];
}
