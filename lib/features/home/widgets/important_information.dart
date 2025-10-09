import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

import '../../../constants/app_images.dart';

class ImportantInformation extends StatelessWidget {
  const ImportantInformation({super.key});

  final List<Map<String, dynamic>> items = const [
    {'title': 'Korxona tarixi', 'icon': 'assets/icons/history.png'},
    {'title': 'Telefon raqamlar', 'icon': 'assets/icons/phone.png'},
    {'title': 'Email ro‘yxati', 'icon': 'assets/icons/email.png'},
    {'title': 'Lavozimlar', 'icon': 'assets/icons/position.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      // margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: AssetImage(AppImages.malumotlarOynasi),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () => debugPrint("${item['title']} bosildi"),
              child: Container(
                width: 90.w,
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(

                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.black, width: 1),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 5,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['icon'],
                      height: 50.h,
                      width: 50.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
