import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../global/widgets/app_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/footer_link.dart';
import '../widgets/phone_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(title: 'Shaxsiy kabinetga kirish', showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      image: AssetImage(AppImages.loginLogo),
                      height: 140.h,
                    ),
                  ],
                ),
                Column(
                  children: [
                    PhoneTextField(
                      controller: phoneController,
                      currentFocus: phoneFocus,
                      nextFocus: passwordFocus, // bu endi ishlaydi
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      label: "Parol",
                      hintText: "6 ta belgidan kam bo'lmagan",
                      controller: passwordController,
                      focusNode: passwordFocus, // muhim: focus node ulanmoqda
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      isPasswordField: true,
                      onSubmitted: (_) => _onLoginPressed(),
                    ),
                    12.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutesNames.forgot);
                        },
                        child: Text(
                          "Parolni unutdingizmi?",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    40.h.verticalSpace,
                  ],
                ),
                Column(
                  children: [
                    CustomButton(text: "Kirish", onPressed: _onLoginPressed),
                    18.verticalSpace,
                    FooterLink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    FormValidator.validateLogin(
      context: context,
      phone: phone,
      password: password,
      routeName: AppRoutesNames.home,
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }
}
