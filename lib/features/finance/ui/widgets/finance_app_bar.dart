import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/features/home/ui/widgets/custom_card_button.dart';

class FinanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMonthly;

  const FinanceAppBar({super.key, required this.isMonthly});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Moliyaviy ma'lumotlar"),
      backgroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        color: AppColors.secondaryColor,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      automaticallyImplyLeading: false,
      actions: [
        if (!isMonthly)
          CustomCardButton(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Yillik ma’lumot yuklanmoqda...'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Icon(Icons.download, size: 24.sp, color: AppColors.black),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
