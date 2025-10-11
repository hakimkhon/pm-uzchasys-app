import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/constants/app_images.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/footer_link.dart';
import '../widgets/phone_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final phoneFocus = FocusNode();
  final newPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(title: "Ro'yxatdan o'tish", showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SizedBox(
            height: 0.85.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    20.h.verticalSpace,
                    Image(
                      image: AssetImage(AppImages.registerLogo),
                      height: 140.h,
                    ),
                  ],
                ),
                Column(
                  children: [
                    // Phone Number Field
                    PhoneTextField(
                      controller: phoneController,
                      currentFocus: phoneFocus,
                      nextFocus: newPasswordFocus,
                    ),

                    20.verticalSpace,

                    // Password Field
                    CustomTextField(
                      label: "Yangi parol",
                      hintText: "6 ta belgidan kam bo'lmagan",
                      controller: passwordController,
                      focusNode: newPasswordFocus, // muhim: focus node ulanmoqda
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      isPasswordField: true,
                    ),
                    20.verticalSpace,
                    // Password Field
                    CustomTextField(
                      label: "Parolni tasdiqlang",
                      hintText: "Yangi parolni qayta kiriting",
                      controller: confirmController,
                      keyboardType: TextInputType.visiblePassword,
                      isPasswordField: true,
                    ),
                    80.h.verticalSpace,
                  ],
                ),

                //button
                Column(
                  children: [
                    CustomButton(
                      text: "Account yaratish",
                      onPressed: _onRegisterPressed,
                    ),
                    18.verticalSpace,
                    // Register link
                    FooterLink(
                      routeName: AppRoutesNames.login,
                      linkText: "Kirish",
                      questionText: "Akkountingiz bormi? ",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmController.text.trim();

    FormValidator.validateRegister(
      context: context,
      phone: phone,
      newPassword: password,
      confirmPassword: confirmPassword,
      routeName: AppRoutesNames.confirm, // masalan tasdiqlash sahifasi
      argument: phone,
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    phoneFocus.dispose();
    newPasswordFocus.dispose();
    super.dispose();
  }
}
