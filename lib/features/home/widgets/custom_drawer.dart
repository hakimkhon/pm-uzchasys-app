import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      color: Colors.blue.shade700,
      padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mening profilim",
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          30.h.verticalSpace,
          drawerItem(Icons.person, "Profil"),
          drawerItem(Icons.settings, "Sozlamalar"),
          drawerItem(Icons.logout, "Chiqish"),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          12.w.horizontalSpace,
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        ],
      ),
    );
  }
}
