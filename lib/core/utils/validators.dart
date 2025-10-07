import 'package:flutter/material.dart';

import '../routes/navigation_service.dart';
import 'app_snackbar.dart';

class FormValidator {
  // Telefon regex: +998 93 123 45 67
  static final RegExp _uzPhoneRegex = RegExp(
    r'^\+998\s\d{2}\s\d{3}\s\d{2}\s\d{2}$',
  );
  // Minimum parol uzunligi (o'zgartirish mumkin)
  static const int minPasswordLength = 6;

  // --- Basic checks (return bool) ---
  static bool isPhoneValid(String phone) {
    return _uzPhoneRegex.hasMatch(phone);
  }

  static bool isPasswordValid(String password) {
    return password.isNotEmpty && password.length >= minPasswordLength;
  }

  static bool doPasswordsMatch(String a, String b) {
    return a == b;
  }

  // LOGIN TEKSHIRUV
  static bool validateLogin({
    required BuildContext context,
    required String phone,
    required String password,
    String? routeName, // ixtiyoriy sahifa
  }) {
    if (phone.isEmpty) {
      AppSnackBar.show(
        context,
        key: 'warning',
        value: 'Iltimos telefon raqamni kiriting',
      );
      return false;
    }

    if (!isPhoneValid(phone)) {
      AppSnackBar.show(
        context,
        key: 'error',
        value:
            'Telefon format noto‘g‘ri. +998 XX XXX XX XX ko‘rinishda kiriting',
      );
      return false;
    }

    // optional: enforce minimum length
    if (!isPasswordValid(password)) {
      AppSnackBar.show(
        context,
        key: 'error',
        value: 'Parol kamida $minPasswordLength belgidan iborat bo‘lishi kerak',
      );
      return false;
    }

    AppSnackBar.show(
      context,
      key: 'success',
      value: 'telefon: $phone , parol: $password',
    );

    // Faqat routeName kelsa navigatsiya qiladi
    if (routeName != null) {
      NavigationService.instance.pushNamedAndRemoveUntil(routeName: routeName);
    }

    return true;
  }

  // REGISTER TEKSHIRUV
  static bool validateRegister({
    required BuildContext context,
    required String phone,
    required String newPassword,
    required String confirmPassword,
    String? routeName, // ixtiyoriy sahifa
    String? argument, // ixtiyoriy argument
  }) {
    if (phone.isEmpty) {
      AppSnackBar.show(
        context,
        key: 'warning',
        value: 'Iltimos telefon raqamni kiriting',
      );
      return false;
    }

    if (!isPhoneValid(phone)) {
      AppSnackBar.show(
        context,
        key: 'error',
        value:
            'Telefon format noto‘g‘ri. +998 XX XXX XX XX ko‘rinishda kiriting',
      );
      return false;
    }

    if (newPassword.isEmpty) {
      AppSnackBar.show(
        context,
        key: 'warning',
        value: 'Iltimos yangi parolni kiriting',
      );
      return false;
    }

    if (!isPasswordValid(newPassword)) {
      AppSnackBar.show(
        context,
        key: 'error',
        value: 'Parol kamida $minPasswordLength belgidan iborat bo‘lishi kerak',
      );
      return false;
    }

    if (confirmPassword.isEmpty) {
      AppSnackBar.show(
        context,
        key: 'warning',
        value: 'Iltimos parolni qaytadan kiriting',
      );
      return false;
    }

    if (!doPasswordsMatch(newPassword, confirmPassword)) {
      AppSnackBar.show(
        context,
        key: 'error',
        value: 'Yangi parol va takrorlangan parol mos emas',
      );
      return false;
    }

    AppSnackBar.show(
      context,
      key: 'success',
      value: 'Telefon: $phone, parol muvaffaqiyatli tekshirildi',
    );

    // Faqat routeName kelsa navigatsiya qiladi
    if (routeName != null) {
      NavigationService.instance.pushNamedAndRemoveUntil(routeName: routeName, arguments: argument);
    }

    return true;
  }
}
