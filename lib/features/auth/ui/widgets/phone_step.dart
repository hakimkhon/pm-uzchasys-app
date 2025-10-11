import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import 'phone_text_field.dart';

class PhoneStep extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode phoneFocus;
  final FocusNode? nextFocus;
  final ValueChanged<String> onChanged;

  const PhoneStep({super.key, 
    required this.phoneController,
    required this.phoneFocus,
    required this.nextFocus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('phoneStep'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          "Tizimda ro'yxatdan o'tgan telefon raqamingizni kiriting.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 20),
        PhoneTextField(
          controller: phoneController,
          currentFocus: phoneFocus,
          nextFocus: nextFocus,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
