import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/constants/app_images.dart';
import 'package:uzchasys_app/constants/const_informations.dart';

class ImportantInformation extends StatelessWidget {
  const ImportantInformation({super.key});

  // Ekrandagi kartochkalar (ikonka + sarlavha)
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
              onTap: () => _showInfoBottomSheet(context, index),
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
                    Image.asset(item['icon'], height: 50.h, width: 50.w),
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

  // --- BottomSheet funksiyasi ---
  void _showInfoBottomSheet(BuildContext context, int index) {
    final info = ConstInformations.list[index];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) => Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView(
            controller: controller,
            children: [
              // Drag indikator
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // Sarlavha
              Text(
                info['title']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              SizedBox(height: 10.h),

              // Tavsif
              Text(
                info['description']!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
