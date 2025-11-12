// lib/widgets/document/signature_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import '../../widgets/signature_pad.dart';

class SignatureSection extends StatelessWidget {
  final GlobalKey<SignaturePadState> signaturePadKey;
  final VoidCallback onClear;
  final VoidCallback onDraw;

  const SignatureSection({
    super.key,
    required this.signaturePadKey,
    required this.onClear,
    required this.onDraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Imzoyingizni qo\'ying',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.red),
                  onPressed: onClear,
                ),
              ],
            ),
          ),
          Expanded(
            child: SignaturePad(
              key: signaturePadKey,
              onClear: onClear,
              onDraw: onDraw,
            ),
          ),
        ],
      ),
    );
  }
}