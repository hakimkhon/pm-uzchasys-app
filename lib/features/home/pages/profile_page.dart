import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: AppColors.background,

      body: Center(
        child: Text(
          'Profil sahifasi',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
      ),
    );
  }
}
