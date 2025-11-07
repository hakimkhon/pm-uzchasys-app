import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Ma'lumotnomalar",
        backRouteName: AppRoutesNames.home,
      ),
      body: Center(
        child: Text(
          "Bu yerda xodimlar uchun ma’lumotnomalar ro‘yxati bo‘ladi.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
