import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

import '../../../service/ui/pages/service_detail_page.dart';


class DocumentPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'icon': 'assets/images/doc_template.png', 'title': 'Erkin shablonlar'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Lavozimdan ozod etish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Ish haqi saqlangan holda ta\'til'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Ish haqi saqlanmagan holda ta\'til'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Ta\'tilga chiqish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Kasallik varaqasi'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Boshqa lavozimlga o\'tkazish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Imtiyozdan foydalanish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Rozilik berish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Moddiy yordam'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Fara sotib olish'},
    {'icon': 'assets/images/doc_template.png', 'title': 'Tushintirish xati'},

  ];

  DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Xujjatlar',
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
            crossAxisCount: 3, // 2x3 joylashuv
            mainAxisSpacing: 24.h,
            crossAxisSpacing: 24.w,
            childAspectRatio: 0.6,
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
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
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
                    Image.asset(item['icon']!, height: 80.h, width: 80.w),
                    10.h.verticalSpace,
                    Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14.sp,
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
