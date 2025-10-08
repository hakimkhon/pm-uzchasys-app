import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigation_service.dart';

class NewPasswordBottomSheet extends StatefulWidget {
  const NewPasswordBottomSheet({super.key});

  @override
  State<NewPasswordBottomSheet> createState() => _NewPasswordBottomSheetState();
}

class _NewPasswordBottomSheetState extends State<NewPasswordBottomSheet> {
  final newPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 60,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Yangi parolni kiriting",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            20.h.verticalSpace,
            TextField(
              controller: newPasswordController,
              obscureText: !isPasswordVisible,
              onChanged: (value) {
                setState(() => isPasswordValid = value.trim().length >= 6);
              },
              decoration: InputDecoration(
                labelText: "Yangi parol",
                hintText: "Kamida 6 ta belgidan iborat",
               
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() => isPasswordVisible = !isPasswordVisible);
                  },
                ),
              ),
            ),
            30.h.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isPasswordValid
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Parol muvaffaqiyatli o‘zgartirildi"),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                        NavigationService.instance.pushNamedAndRemoveUntil(
                          routeName: AppRoutesNames.login,
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPasswordValid
                      ? AppColors.primaryColor
                      : AppColors.secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Saqlash",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}