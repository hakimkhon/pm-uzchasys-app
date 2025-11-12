// lib/widgets/document/document_content.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentContent extends StatelessWidget {
  const DocumentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hujjat mazmuni',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // AppColors.secondaryColor
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              """
              Bu yerda hujjat matni joylashadi. Hozircha namuna matn sifatida quyidagi paragraf keltirilgan:
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
              yana bir nechta jumlalar bilan hujjat mazmuni to'ldiriladi.
              optional content to demonstrate scrolling behavior in the document content area.
              lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
              optional content to demonstrate scrolling behavior in the document content area.
              with additional lines to ensure the content exceeds the visible area and requires scrolling.
              quiz do eiusmod tempor incididunt ut labore et dolore magna aliqua.

""",
              style: TextStyle(
                fontSize: 15.sp,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}