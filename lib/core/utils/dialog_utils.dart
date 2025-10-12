import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: const Text("Tizimdan chiqish"),
        content: const Text(
          "Haqiqatan ham shaxsiy kabinetdan chiqmoqchimisiz?",
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Bekor qilish",
              style: TextStyle(color: AppColors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              NavigationService.instance.pushNamedAndRemoveUntil(
                routeName: '/login',
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Tizimdan chiqish amalga oshirildi"),
                  duration: Duration(seconds: 2),
                ),
              );
              // Logout funksiyani shu joyda chaqirish mumkin
            },
            child: const Text(
              "Ha, chiqaman",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      );
    },
  );
}
