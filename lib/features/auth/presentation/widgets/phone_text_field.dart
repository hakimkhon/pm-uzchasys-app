import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.currentFocus,
    this.nextFocus,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  void initState() {
    super.initState();
    // Fokus tushganda +998 qo‘shiladi
    widget.currentFocus.addListener(() {
      if (widget.currentFocus.hasFocus &&
          widget.controller.text.isEmpty) {
        widget.controller.text = '+998 ';
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      }
    });
  }

  String _formatNumber(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('998')) digits = digits.substring(3);

    String formatted = '+998 ';
    if (digits.isNotEmpty) {
      formatted += digits.substring(0, digits.length.clamp(0, 2));
    }
    if (digits.length > 2) {
      formatted += ' ${digits.substring(2, digits.length.clamp(2, 5))}';
    }
    if (digits.length > 5) {
      formatted += ' ${digits.substring(5, digits.length.clamp(5, 7))}';
    }
    if (digits.length > 7) {
      formatted += ' ${digits.substring(7, digits.length.clamp(7, 9))}';
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.currentFocus,
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      maxLength: 17,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\+\s]')),
      ],
      decoration: InputDecoration(
        labelText: "Phone Number",
        counterText: "",
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 16.sp,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
      onChanged: (value) {
        final newText = _formatNumber(value);
        if (newText != value) {
          widget.controller.value = TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }

        // To‘liq raqam kiritilganda keyingi fieldga o‘tish
        if (newText.length == 17 && widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
      },
    );
  }
}
