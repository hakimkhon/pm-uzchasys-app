import 'package:flutter/material.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/confirm_code_screen.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/login_screen.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/register_screen.dart';

class AppRoutesNames {
  static const String login = '/login';
  static const String register = '/register';
  static const String confirm = '/confirm';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutesNames.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppRoutesNames.confirm:
        return MaterialPageRoute(
          builder: (context) => const ConfirmCodeScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
