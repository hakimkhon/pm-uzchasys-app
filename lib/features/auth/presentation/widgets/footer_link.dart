import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/app_colors.dart';

class FooterLink extends StatelessWidget {
  final VoidCallback onTap;
  final String questionText;
  final String linkText;

  const FooterLink({
    super.key,
    required this.onTap,
    this.questionText = "New to UzChasys group? ",
    this.linkText = "Register",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryColor),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
