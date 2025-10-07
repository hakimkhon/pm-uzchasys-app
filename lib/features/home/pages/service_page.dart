import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: AppColors.background,

      body: Center(
        child: Text(
          'Xizmatlar sahifasi',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
      ),
    );
  }
}
