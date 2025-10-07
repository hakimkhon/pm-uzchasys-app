import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Navigate to another screen or perform an action
            debugPrint('Button Pressed!');
            NavigationService.instance.pushNamedAndRemoveUntil(
              routeName: AppRoutesNames.login,
            );
          },
          child: const Text('Welcome to the Home Screen!'),
        ),
      ),
    );
  }
}
