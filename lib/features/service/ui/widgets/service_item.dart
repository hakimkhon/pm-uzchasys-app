// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:uzchasys_app/constants/app_colors.dart';

// class ServiceItem extends StatelessWidget {
//   final String icon;
//   final String title;
//   final VoidCallback onTap;

//   const ServiceItem({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16.r),
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.tertiaryColor.withValues(alpha: 0.08),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border(
//             bottom: BorderSide(
//               color: AppColors.primaryColor,
//               width: 6,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(icon, height: 100.h, width: 100.w),
//               20.h.verticalSpace,
//               Text(
//                 title,
//                 // textAlign: TextAlign.center,
//                 // style: TextStyle(
//                 //   color: Colors.black,
//                 //   fontWeight: FontWeight.w500,
//                 //   fontSize: 18.sp,
//                 //   height: 1.2,
//                 // ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
