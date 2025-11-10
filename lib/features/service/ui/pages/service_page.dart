import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {'icon': 'assets/icons/service1.png', 'title': 'Ruxsatnoma portali'},
    {'icon': 'assets/icons/service2.png', 'title': 'Mehmon portali'},
    {'icon': 'assets/icons/service3.png', 'title': 'Elektron hujjat almashish tizimi'},
    {'icon': 'assets/icons/service4.png', 'title': 'Elektron pochta tizimi'},
    {'icon': 'assets/icons/service5.png', 'title': 'Kerio Control'},
    {'icon': 'assets/icons/service6.png', 'title': 'Face ID tizimi'},
  ];

  ServicesPage({super.key});

  // Xizmatlar URL ro'yxati
  String? _getServiceUrl(String title) {
    switch (title) {
      case 'Ruxsatnoma portali':
        return 'http://ruhsatnoma.uzchasys.uz/index.php';
      case 'Mehmon portali':
        return 'http://mehmonportal.local/login';
      case 'Elektron hujjat almashish tizimi':
        return 'http://edo.uzchasys.uz/#/login';
      case 'Elektron pochta tizimi':
        return 'https://mail.uzchasys.uz/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2fmail.uzchasys.uz%2fowa%2f';
      case 'Kerio Control':
        return 'http://kerio.chasys.local:4080/login/';
      case 'Face ID tizimi':
        return 'https://192.168.1.111/#/';
      default:
        return null;
    }
  }

  // URL ni ochish funksiyasi
// URL ni ochish funksiyasi
Future<void> _openUrl(BuildContext context, String title) async {
  final String? urlString = _getServiceUrl(title);
  
  if (urlString == null) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('URL topilmadi')),
    );
    return;
  }

  final Uri url = Uri.parse(urlString);
  
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('URL ochilmadi: $urlString')),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xatolik: $e')),
    );
  }
}

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
            crossAxisCount: 2,
            mainAxisSpacing: 24.h,
            crossAxisSpacing: 24.w,
            childAspectRatio: 0.80,
          ),
          itemBuilder: (context, index) {
            final item = services[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () => _openUrl(context, item['title']!), // Bu yerda o'zgardi
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