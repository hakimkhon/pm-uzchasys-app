import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';

import '../../../constants/app_colors.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = {
      'name': 'Hakimxon Sharifxonov',
      'position': 'AKT bo‘limi mutaxassisi',
      'department': 'Axborot texnologiyalari bo‘limi',
      'phone': '+998 90 123 45 67',
      'email': 'hakimxon@example.com',
      'photo': 'assets/images/profile.png',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.secondaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Profil rasmi
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage(user['photo']!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 22.sp,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Profil rasmini o‘zgartirish funksiyasi hali yoqilgan emas',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              user['name']!,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            Text(
              user['position']!,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              user['department']!,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
            ),

            SizedBox(height: 20.h),

            // Ma’lumotlar kartasi
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.phone, 'Telefon raqam', user['phone']!),
                  Divider(height: 20.h, color: Colors.grey.shade300),
                  _infoRow(Icons.email_outlined, 'Email', user['email']!),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Tugmalar
            ElevatedButton.icon(
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'Shaxsiy ma’lumotlarni tahrirlash',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(user: user),
                  ),
                );
              },
            ),

            SizedBox(height: 12.h),

            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Chiqish'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                side: BorderSide(color: AppColors.primaryColor),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tizimdan chiqish amalga oshirildi'),
                  ),
                );
                NavigationService.instance.pushNamedAndRemoveUntil(
                  routeName: AppRoutesNames.login,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
