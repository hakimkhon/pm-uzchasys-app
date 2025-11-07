import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../core/routes/navigation_service.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool centerTitle;
  final Widget? actionWidget;
  final double? titleSize;

  // yangi parametr
  final String? backRouteName; // orqaga bosilganda o'tadigan sahifa nomi

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.centerTitle = true,
    this.actionWidget,
    this.titleSize,
    this.backRouteName, // yangi parametr
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false, // biz o'zimiz nazorat qilamiz
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
              onPressed: () {
                if (backRouteName != null) {
                  // Belgilangan sahifaga o'tish
                  NavigationService.instance.pushReplacementNamed(routeName: backRouteName!);
                } else {
                  // Default — orqaga qaytish
                  Navigator.pop(context);
                }
              },
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleSize ?? 28.sp,
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actionWidget != null ? [actionWidget!] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
