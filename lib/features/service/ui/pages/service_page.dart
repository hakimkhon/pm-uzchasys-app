import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

import 'service_detail_page.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'icon': 'assets/icons/service1.png', 'title': 'Ruxsatnoma portali'},
    {'icon': 'assets/icons/service2.png', 'title': 'Mehmon portali'},
    {'icon': 'assets/icons/service3.png', 'title': 'Elektron hujjat almashish tizimi'},
    {'icon': 'assets/icons/service4.png', 'title': 'Elektron pochta tizimi'},
    {'icon': 'assets/icons/service5.png', 'title': 'Kerio Control'},
    {'icon': 'assets/icons/service6.png', 'title': 'Face ID tizimi'},
    {'icon': 'assets/images/login_logo.png', 'title': 'Face ID tizimi'},
  ];

  ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Tizim va Xizmatlar',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.secondaryColor, size: 26.sp),
            onPressed: () {
              // qidiruv logikasi shu yerda yoziladi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Qidiruv funksiyasi tez orada...')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2x3 joylashuv
            mainAxisSpacing: 24.h,
            crossAxisSpacing: 24.w,
            childAspectRatio: 0.80,
          ),
          itemBuilder: (context, index) {
            final item = services[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailPage(service: item),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border(
                    bottom: BorderSide(color: AppColors.primaryColor, width: 6),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(item['icon']!, height: 110.h, width: 110.w),
                    15.h.verticalSpace,
                    Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
