import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

import '../../../../core/utils/profile_notifier.dart';
import '../../../../global/widgets/app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      setState(() => _profileImage = file);
      profileImageNotifier.value = file; // <<< Drawer uchun yangilanish
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userData;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Shaxsiy kabinet",
        titleSize: 24.sp,
        centerTitle: false,
      ),

      backgroundColor: Colors.grey[100],
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
                    backgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.2,
                    ),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/images/default_user.png')
                              as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            14.h.verticalSpace,

            Text(
              user["full_name"] ?? "",
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
            ),
            6.h.verticalSpace,
            Text(
              user["position_name"] ?? "",
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 14.sp,
              ),
            ),
            4.h.verticalSpace,
            Text(
              user["department_name"] ?? "",
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 13.sp,
              ),
            ),

            10.h.verticalSpace,

            // Ma'lumotlar kartasi
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _infoRow('Tabel raqami', user['tabel_num']),
                  _divider(),
                  _infoRow('Telefon raqami', user['phone_num']),
                  _divider(),
                  _infoRow('Tug‘ilgan sana', user['born']),
                  _divider(),
                  _infoRow('Ish boshlagan sana', user['started_date']),
                  _divider(),
                  _infoRow('JSHSHIR', user['jshshir']),
                  _divider(),
                  _infoRow('Bo‘lim kodi', user['department_code']),
                  _divider(),
                  _infoRow('Lavozim kodi', user['position_code']),
                  _divider(),
                  _infoRow('Ish jadvali', user['work_schedule']),
                  _divider(),
                  _infoRow(
                    'Yangi lavozim sanasi',
                    user['started_new_position_date'],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value != null && value.toString().isNotEmpty
                  ? value.toString()
                  : "—",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Divider(height: 10.h, color: Colors.grey.shade300);
}




// class ProfilePage extends StatefulWidget {
//   final Map<String, dynamic> userData;

//   const ProfilePage({super.key, required this.userData});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? _profileImage;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _profileImage = File(pickedFile.path));
//       // kerak bo‘lsa bu joyda serverga yuklash funksiyasini chaqirasiz
//       debugPrint("Yangi rasm yo‘li: ${pickedFile.path}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = widget.userData;


