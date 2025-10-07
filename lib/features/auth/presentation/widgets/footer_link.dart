import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/routes/navigation_service.dart';

class FooterLink extends StatelessWidget {
  final String routeName;
  final String questionText;
  final String linkText;

  const FooterLink({
    super.key,
    this.routeName = AppRoutesNames.register,
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
           onTap: (){
            NavigationService.instance.pushNamed(
              routeName: routeName,
            );},
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