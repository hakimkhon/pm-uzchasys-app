import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/profile_notifier.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.w,
      color: Colors.blue.shade800,
      padding: EdgeInsets.symmetric(vertical: 70.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil rasmi — ValueNotifier bilan kuzatamiz
          Center(
            child: ValueListenableBuilder<File?>(
              valueListenable: profileImageNotifier,
              builder: (context, file, _) {
                return CircleAvatar(
                  radius: 55.r,
                  backgroundColor: AppColors.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  backgroundImage: file != null
                      ? FileImage(file)
                      : const AssetImage('assets/images/default_user.png')
                            as ImageProvider,
                );
              },
            ),
          ),
          14.h.verticalSpace,
          Center(
            child: Text(
              "Mening profilim",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          14.h.verticalSpace,

          drawerItem(
            Icons.insert_drive_file_rounded,
            "Ma'lumotnomalar",
            onTap: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.info,
              );
            },
          ),

          drawerItem(
            Icons.notifications,
            "Bildirishnomalar",
            onTap: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.notification,
              );
            },
          ),
          drawerItem(
            Icons.settings,
            "Sozlamalar",
            onTap: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.settings,
              );
            },
          ),
          drawerItem(
            Icons.info_outline,
            "Ilova haqida",
            onTap: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.about,
              );
            },
          ),
          drawerItem(
            Icons.help_outline,
            "Yordam",
            onTap: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: AppRoutesNames.help,
              );
            },
          ),
          const Spacer(),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          drawerItem(
            Icons.logout,
            "Chiqish",
            onTap: () => showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
