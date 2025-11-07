import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Ilova haqida",
        backRouteName: AppRoutesNames.home,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UzChasys ilovasi haqida",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "Bu ilova xodimlarning deklaratsiyalarini, ma’lumotnomalarini va hujjatlarni boshqarish uchun ishlab chiqilgan.",
              style: TextStyle(fontSize: 16.sp, height: 1.5),
            ),
            SizedBox(height: 20.h),
            Text("Versiya: 1.0.0", style: TextStyle(fontSize: 16.sp)),
            Text("Dasturchi: Digital IT Group", style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}
