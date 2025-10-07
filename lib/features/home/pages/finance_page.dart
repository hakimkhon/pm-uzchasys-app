import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: AppColors.background,

      body: Center(
        child: Text(
          'Moliya sahifasi',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade700),
        ),
      ),
    );
  }
}
