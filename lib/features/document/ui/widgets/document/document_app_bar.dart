// lib/widgets/document/document_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class DocumentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onPrint;
  final VoidCallback onSave;

  const DocumentAppBar({
    super.key,
    required this.title,
    required this.onBack,
    required this.onPrint,
    required this.onSave,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
        onPressed: onBack,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit_document, color: AppColors.secondaryColor),
          onPressed: onPrint,
          tooltip: 'O\'zgartirish',
        ),
        IconButton(
          icon: Icon(Icons.download, color: AppColors.secondaryColor),
          onPressed: onSave,
          tooltip: 'Yuklab olish',
        ),
      ],
    );
  }
}