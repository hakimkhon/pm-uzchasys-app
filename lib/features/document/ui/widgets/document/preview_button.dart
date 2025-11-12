// lib/widgets/document/preview_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class PreviewButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const PreviewButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: SizedBox(
        width: double.infinity,
        height: 45.h,
        child: ElevatedButton.icon(
          onPressed: enabled ? onPressed : null,
          icon: Icon(Icons.visibility, size: 20.sp),
          label: Text('Ko\'rib chiqish va Chop etish'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
    );
  }
}