import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import 'otp_input_field.dart';

class OtpStep extends StatelessWidget {
  final String savedPhone;
  final FocusNode verificationCodeFocus;
  final ValueChanged<String> onCompleted;

  const OtpStep({super.key, 
    required this.savedPhone,
    required this.verificationCodeFocus,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('otpStep'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        OtpInputField(onCompleted: onCompleted),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kod kelmadimi? ",
              style: TextStyle(color: AppColors.secondaryColor, fontSize: 16),
            ),
            TextButton(
              onPressed: () => debugPrint("Kod qayta yuborildi"),
              child: const Text(
                "Qayta yuborish",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Tasdiqlash kodi $savedPhone raqamiga yuborildi.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
