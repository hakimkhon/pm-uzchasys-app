import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(
        title: 'Login',
        showBackButton: false,
      ),
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
                    Image.asset('assets/images/login_logo.png', height: 140.h),
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
                      label: "Password",
                      controller: passwordController,
                      focusNode: passwordFocus, // muhim: focus node ulanmoqda
                      textInputAction: TextInputAction.done,
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
                          "Forgot password",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                    40.h.verticalSpace,
                  ],
                ),
                Column(
                  children: [
                    CustomButton(text: "Sign in", onPressed: _onLoginPressed),
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
