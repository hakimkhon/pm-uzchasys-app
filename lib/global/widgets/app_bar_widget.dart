import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool centerTitle;
  final Widget? actionWidget; // bu endi IconData emas, to‘g‘ridan-to‘g‘ri Widget
  final double? titleSize;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.centerTitle = true,
    this.actionWidget,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButton,
      iconTheme: IconThemeData(color: AppColors.secondaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleSize ?? 20.sp,
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