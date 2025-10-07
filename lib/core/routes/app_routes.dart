import 'package:flutter/material.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/confirm_code_screen.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/forgot_pass_screen.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/login_screen.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/register_screen.dart';
import 'package:uzchasys_app/features/home/home_screen.dart';

class AppRoutesNames {
  static const String login = '/login';
  static const String register = '/register';
  static const String confirm = '/confirm';
  static const String home = '/home';
  static const String forgot = '/forgot';
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
          builder: (context) => ConfirmCodeScreen(phoneNumber: settings.arguments as String),
        );
      case AppRoutesNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoutesNames.forgot:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
