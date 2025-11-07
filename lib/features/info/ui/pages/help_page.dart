import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Yordam",
        backRouteName: AppRoutesNames.home,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ko‘p so‘raladigan savollar",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("Ilovaga qanday kirish mumkin?"),
              subtitle: const Text("Login va parol orqali tizimga kiriladi."),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("Parolni unutdim, nima qilaman?"),
              subtitle: const Text("Parolni tiklash uchun 'Parolni unutdingizmi?' bo‘limidan foydalaning."),
            ),
          ],
        ),
      ),
    );
  }
}
