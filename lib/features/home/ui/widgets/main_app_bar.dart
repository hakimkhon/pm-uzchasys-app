import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_images.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';
import 'custom_card_button.dart';

class MainAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  const MainAppBar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCardButton(
          onTap: onMenuTap,
          child: Icon(Icons.menu, size: 30.sp),
        ),
        Image(height: 70.h, image: AssetImage(AppImages.carLogo)),
        CustomCardButton(
          onTap: () {
            NavigationService.instance.pushNamed(
              routeName: AppRoutesNames.notification,
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.notifications_none, size: 30.sp),
              Positioned(
                right: -11,
                top: -11,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "9",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
