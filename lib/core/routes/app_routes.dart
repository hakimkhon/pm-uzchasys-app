import 'package:flutter/material.dart';
import 'package:uzchasys_app/features/auth/ui/pages/confirm_code_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/forgot_pass_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/login_screen.dart';
import 'package:uzchasys_app/features/auth/ui/pages/register_screen.dart';
import 'package:uzchasys_app/features/document/ui/pages/document_page.dart';
import 'package:uzchasys_app/features/home/ui/pages/home_page.dart';
import 'package:uzchasys_app/features/info/ui/pages/about_page.dart';
import 'package:uzchasys_app/features/info/ui/pages/help_page.dart';
import 'package:uzchasys_app/features/info/ui/pages/info_page.dart';
import 'package:uzchasys_app/features/info/ui/pages/settings_page.dart';
import 'package:uzchasys_app/features/notification/ui/pages/notifications_page.dart';
import 'package:uzchasys_app/features/service/ui/pages/service_page.dart';

import '../../features/user/ui/pages/profile_page.dart';

class AppRoutesNames {
  static const String login = '/login';
  static const String register = '/register';
  static const String confirm = '/confirm';
  static const String home = '/home';
  static const String forgot = '/forgot';
  static const String notification = '/notification';
  static const String documents = '/documents';
  static const String profile = '/profile';
  static const String service = '/service';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';
  static const String info = '/info';
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
          builder: (context) =>
              ConfirmCodeScreen(phoneNumber: settings.arguments as String),
        );
      case AppRoutesNames.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRoutesNames.forgot:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case AppRoutesNames.notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationsPage(),
        );
      case AppRoutesNames.documents:
        return MaterialPageRoute(builder: (context) => DocumentPage());
      case AppRoutesNames.profile:
        return MaterialPageRoute(
          builder: (context) =>
              ProfilePage(userData: settings.arguments as Map<String, dynamic>),
        );

      case AppRoutesNames.service:
        return MaterialPageRoute(builder: (context) => ServicesPage());

      case AppRoutesNames.settings:
        return MaterialPageRoute(builder: (context) => const SettingsPage());

      case AppRoutesNames.about:
        // Placeholder for About Page
        return MaterialPageRoute(builder: (context) => const AboutPage());

      case AppRoutesNames.help:
        // Placeholder for Help Page
        return MaterialPageRoute(builder: (context) => const HelpPage());
      case AppRoutesNames.info:
        // Placeholder for Help Page
        return MaterialPageRoute(builder: (context) => const InfoPage());

      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
