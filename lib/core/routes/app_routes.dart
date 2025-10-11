import 'package:flutter/material.dart';
import 'package:uzchasys_app/features/auth/ui/pages/confirm_code_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/forgot_pass_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/login_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/register_screen.dart';
import 'package:uzchasys_app/features/home/ui/pages/home_page.dart';
import 'package:uzchasys_app/features/notification/ui/pages/notifications_page.dart';

class AppRoutesNames {
  static const String login = '/login';
  static const String register = '/register';
  static const String confirm = '/confirm';
  static const String home = '/home';
  static const String forgot = '/forgot';
  static const String notification = '/notification';
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
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRoutesNames.forgot:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
      case AppRoutesNames.notification:
        return MaterialPageRoute(builder: (context) => const NotificationsPage());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
