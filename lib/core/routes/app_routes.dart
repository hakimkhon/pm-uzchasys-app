import 'package:flutter/material.dart';
import 'package:uzchasys_app/features/auth/presentation/pages/login_screen.dart';

class AppRoutesNames {
  static const String login = '/login';

}

class AppRoutes {

  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}