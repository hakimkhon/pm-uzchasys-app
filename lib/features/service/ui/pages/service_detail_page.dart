// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uzchasys_app/constants/app_colors.dart';
// import 'package:uzchasys_app/core/routes/app_routes.dart';

// import '../../../../global/widgets/app_bar_widget.dart';

// class ServiceDetailPage extends StatelessWidget {
//   final Map<String, String> service;
//   const ServiceDetailPage({super.key, required this.service});

//   // Xizmatlar URL ro‘yxati
//   String? _getServiceUrl(String title) {
//     switch (title) {
//       case 'Ruxsatnoma portali':
//         return 'http://ruhsatnoma.uzchasys.uz/index.php';
//       case 'Mehmon portali':
//         return 'http://mehmonportal.local/login';
//       case 'Elektron hujjat almashish tizimi':
//         return 'http://edo.uzchasys.uz/#/login';
//       case 'Elektron pochta tizimi':
//         return 'https://mail.uzchasys.uz/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2fmail.uzchasys.uz%2fowa%2f';
//       case 'Kerio Control':
//         return 'http://kerio.chasys.local:4080/login/';
//       case 'Face ID tizimi':
//         return 'https://192.168.1.111/#/';
//       default:
//         return null;
//     }
//   }

//   Future<void> _openServiceSite(BuildContext context) async {
//     final url = _getServiceUrl(service['title'] ?? '');
//     if (url == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Sayt manzili topilmadi')),
//       );
//       return;
//     }

//     final Uri uri = Uri.parse(url);

//     try {
//       final canLaunch = await canLaunchUrl(uri);
//       if (!canLaunch) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Sayt manzili ochilmadi')),
//         );
//         return;
//       }

//       // Saytni tashqi brauzerda ochish
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Xatolik: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: const AppBarWidget(
//         title: "Xizmat tafsilotlari",
//         backRouteName: AppRoutesNames.service,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             20.h.verticalSpace,
//             Image.asset(service['icon']!, height: 150.h, width: 150.w),
//             20.h.verticalSpace,
//             Text(
//               service['title'] ?? '',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 22.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.secondaryColor,
//               ),
//             ),
//             25.h.verticalSpace,
//             Text(
//               "Tizimdan foydalanish uchun quyidagi tugmani bosing.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16.sp, height: 1.5),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               height: 50.h,
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 onPressed: () => _openServiceSite(context),
//                 icon: const Icon(Icons.language, color: Colors.white),
//                 label: Text(
//                   "Saytga o‘tish",
//                   style: TextStyle(color: Colors.white, fontSize: 18.sp),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
