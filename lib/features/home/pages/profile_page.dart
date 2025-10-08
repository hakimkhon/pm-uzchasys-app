import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('ProfilePage'),
      child: Column(
        children: [
          Center(
            child: Text(
              'Profile sahifasi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.login,
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
