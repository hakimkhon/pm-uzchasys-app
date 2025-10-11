import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/constants/app_images.dart';

class FavoriteServices extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'icon': AppImages.favotireServices, 'title': 'Korxona tarixi'},
    {'icon': AppImages.favotireServices, 'title': 'Telefon raqamlar'},
    {'icon': AppImages.favotireServices, 'title': 'Email ro‘yxati'},
    {'icon': AppImages.favotireServices, 'title': 'Lavozimlar'},
    {'icon': AppImages.favotireServices, 'title': 'Bo‘limlar'},
    {'icon': AppImages.favotireServices, 'title': 'Manzillar'},
  ];

  FavoriteServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
          childAspectRatio: 0.76, // eni va bo‘yi muvozanatda
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final item = services[index];
          return InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              // bu joyda har bir item uchun amaliyot yozish mumkin
              debugPrint('Bosildi: ${item['title']}');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.tertiaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryColor,
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon']!,
                    height: 60.h,
                    width: 80.w,
                  ),
                  Center(
                    child: Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
