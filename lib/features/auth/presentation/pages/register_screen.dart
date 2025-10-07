import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/constants/app_images.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/routes/navigation_service.dart';
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
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(
        title: 'Register',
        titleSize: 30.sp,
        showBackButton: false,
      ),
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
                      nextFocus: passwordFocus,
                    ),

                    20.verticalSpace,

                    // Password Field
                    CustomTextField(
                      label: "New password",
                      controller: newPasswordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    20.verticalSpace,

                    // Password Field
                    CustomTextField(
                      label: "Confirm password",
                      controller: confirmPasswordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  40.h.verticalSpace,
                  ],
                ),

                //button
                Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                        NavigationService.instance.pushNamed(
                          routeName: AppRoutesNames.confirm,
                        );
                      },
                      text: "Create account",
                    ),

                    18.verticalSpace,
                    // Register link
                    FooterLink(
                      onTap: () {
                        NavigationService.instance.pushNamedAndRemoveUntil(
                          routeName: AppRoutesNames.login,
                        );
                      },
                      linkText: "Sign in",
                      questionText: "Already have an account? ",
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

  @override
  void dispose() {
    phoneController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
