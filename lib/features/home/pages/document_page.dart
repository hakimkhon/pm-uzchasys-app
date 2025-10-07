import 'package:flutter/material.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Hujjat sahifasi',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade700,
          ),
        ),
      ),
    );
  }
}
