import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/view/login_page.dart';
import '../../features/register/view/register_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';

  static const String loginName = 'login';
  static const String registerName = 'register';
  static const String homeName = 'home';
  static const String profileName = 'profile';

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
          _buildPageWithFadeTransition(const LoginView(), state),
    ),
    GoRoute(
      path: register,
      name: registerName,
      pageBuilder: (context, state) =>
          _buildPageWithFadeTransition(const RegisterView(), state),
    ),
    GoRoute(
      path: home,
      name: homeName,
      pageBuilder: (context, state) => _buildPageWithTransition(
        const Scaffold(body: Center(child: Text('Home Page'))),
        state,
      ),
    ),
    GoRoute(
      path: profile,
      name: profileName,
      pageBuilder: (context, state) => _buildPageWithTransition(
        const Scaffold(body: Center(child: Text('Profile Page'))),
        state,
      ),
    ),
  ];
}
