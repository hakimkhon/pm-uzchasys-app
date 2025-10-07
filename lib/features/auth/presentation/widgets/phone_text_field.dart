import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../constants/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final ValueChanged<String>? onChanged; // tashqaridan signal olish uchun

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.currentFocus,
    this.nextFocus,
    this.onChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late final MaskTextInputFormatter maskFormatter;

  @override
  void initState() {
    super.initState();

    maskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    // Fokus tushganda avtomatik +998 qo‘shiladi
    widget.currentFocus.addListener(() {
      if (widget.currentFocus.hasFocus && widget.controller.text.isEmpty) {
        widget.controller.text = "+998 ";
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.currentFocus,
      keyboardType: TextInputType.phone,
      textInputAction:
          widget.nextFocus != null ? TextInputAction.next : TextInputAction.done,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\+\s]')),
        maskFormatter,
      ],
      maxLength: 17, // +998 XX XXX XX XX
      decoration: InputDecoration(
        labelText: "Phone Number",
        counterText: "",
        labelStyle: const TextStyle(color: AppColors.secondaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.tertiaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
      onChanged: (value) {
        final digits = maskFormatter.getUnmaskedText();

        // Tashqariga signal yuborish (masalan forgot_password sahifasida)
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }

        // To‘liq raqam kiritilganda avtomatik keyingi maydonga o'tish
        if (digits.length == 9) {
          if (widget.nextFocus != null) {
            widget.nextFocus!.requestFocus();
          } else {
            widget.currentFocus.unfocus();
          }
        }
      },
      onSubmitted: (_) {
        // Enter bosilganda keyingi maydonga o‘tish
        if (widget.nextFocus != null) {
          widget.nextFocus!.requestFocus();
        } else {
          widget.currentFocus.unfocus();
        }
      },
    );
  }
}
