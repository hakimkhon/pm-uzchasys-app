import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/global/widgets/app_bar_widget.dart';
import '../../../../constants/app_images.dart';
import '../widgets/new_password_bottom_sheet.dart';
import '../widgets/otp_step.dart';
import '../widgets/phone_step.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final phoneController = TextEditingController();
  final newPasswordController = TextEditingController();
  final phoneFocus = FocusNode();
  final verificationCodeFocus = FocusNode();

  bool isPhoneEntered = false;
  bool isButtonActive = false;
  String enteredCode = "";
  String savedPhone = "";

  // OTP kiritilganda
  void handleOtpComplete(String code) {
    setState(() {
      enteredCode = code;
      isButtonActive = code.length == 6;
    });
    FocusScope.of(context).unfocus();

    if (code == "666666") {
      Future.delayed(const Duration(milliseconds: 300), () {
        _showNewPasswordBottomSheet();
      });
    }
  }

  // Telefon raqam to‘liq kiritilganda
  void handlePhoneChange(String value) {
    if (value.length == 17) {
      setState(() {
        savedPhone = value;
        isPhoneEntered = true;
      });
      FocusScope.of(context).requestFocus(verificationCodeFocus);
    }
  }

  // Yangi parol oynasi
  void _showNewPasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => NewPasswordBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(title: 'Parolni tiklash', showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              20.h.verticalSpace,
              Image(image: AssetImage(AppImages.confirmLogo), height: 140.h),
              20.h.verticalSpace,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: !isPhoneEntered
                    ? PhoneStep(
                        phoneController: phoneController,
                        phoneFocus: phoneFocus,
                        nextFocus: verificationCodeFocus,
                        onChanged: handlePhoneChange,
                      )
                    : OtpStep(
                        savedPhone: savedPhone,
                        verificationCodeFocus: verificationCodeFocus,
                        onCompleted: handleOtpComplete,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    newPasswordController.dispose();
    phoneFocus.dispose();
    verificationCodeFocus.dispose();
    super.dispose();
  }
}
