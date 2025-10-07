import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/constants/app_images.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:uzchasys_app/core/routes/navigation_service.dart';
import 'package:uzchasys_app/global/widgets/app_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/footer_link.dart';
import '../widgets/otp_input_field.dart';

class ConfirmCodeScreen extends StatefulWidget {
  final String phoneNumber;
  const ConfirmCodeScreen({super.key, required this.phoneNumber});

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  bool isButtonActive = false;
  String enteredCode = "";

  void handleOtpComplete(String code) {
    setState(() {
      enteredCode = code;
      isButtonActive = code.length == 6;
    });
    FocusScope.of(context).unfocus(); // Fokusni o‘chiradi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(title: 'Verification code', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: 0.85.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    20.h.verticalSpace,
                    Image(
                      image: AssetImage(AppImages.confirmLogo),
                      height: 140.h,
                    ),
                  ],
                ),
                Column(
                  children: [
                    OtpInputField(onCompleted: handleOtpComplete),
                    18.h.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint("Kod qayta yuborildi");
                          },
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    18.h.verticalSpace,
                    Text(
                      "Tasdiqlash kodi UzChasys nomli bot orqali ${widget.phoneNumber} raqamiga ochilgan telegramga jo’natilindi.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      onPressed: isButtonActive
                          ? () {
                              NavigationService.instance
                                  .pushNamedAndRemoveUntil(
                                    routeName: AppRoutesNames.login,
                                  );
                            }
                          : null,
                      text: "Confirm",
                      color: isButtonActive
                          ? AppColors.primaryColor
                          : Colors.grey.shade400,
                    ),
                    18.verticalSpace,
                    FooterLink(linkText: "", questionText: ""),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
