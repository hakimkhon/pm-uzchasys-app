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
import '../widgets/phone_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();
  final verificationCodeFocus = FocusNode();

  bool isPhoneEntered = false;
  bool isButtonActive = false;
  String enteredCode = "";
  String savedPhone = "";

  // OTP to‘liq kiritilganda
  void handleOtpComplete(String code) {
    setState(() {
      enteredCode = code;
      isButtonActive = code.length == 6;
    });
    FocusScope.of(context).unfocus();
  }

  // Telefon raqam to‘liq kiritilganini tekshirish
  void handlePhoneChange(String value) {
    if (value.length == 17) {
      setState(() {
        savedPhone = value;
        isPhoneEntered = true; // Keyingi bosqichga o‘tish
      });
      FocusScope.of(context).requestFocus(verificationCodeFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(title: 'Reset password', showBackButton: true),
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
                      image: AssetImage(AppImages.forgotPassword),
                      height: 140.h,
                    ),
                  ],
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: !isPhoneEntered
                      ? Column(
                          key: const ValueKey('phoneStep'),
                          children: [
                            Text(
                              "Tizimda ro'yxatdan o'tgan telefon raqamingizni kiriting. Tasdiqlash kodi ushbu raqamga yuboriladi.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            18.h.verticalSpace,
                            PhoneTextField(
                              controller: phoneController,
                              currentFocus: phoneFocus,
                              nextFocus: verificationCodeFocus,
                              onChanged: handlePhoneChange,
                            ),
                            120.h.verticalSpace,
                          ],
                        )
                      : Column(
                          key: const ValueKey('otpStep'),
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
                              "Tasdiqlash kodi $savedPhone raqamiga ochilgan telegramga @Chasysbot orqali yuborildi.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
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
                          : AppColors.tertiaryColor,
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

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocus.dispose();
    verificationCodeFocus.dispose();
    super.dispose();
  }
}
