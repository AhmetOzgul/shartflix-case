import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.email_required'.tr();
    }

    if (!value.contains('@')) {
      return 'validation.email_invalid'.tr();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.password_required'.tr();
    }

    if (value.length < 6) {
      return 'validation.password_min_length'.tr();
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.name_required'.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'validation.confirm_password_required'.tr();
    }
    if (password == null || password.isEmpty) {
      return 'validation.password_required'.tr();
    }
    if (value != password) {
      return 'validation.passwords_not_match'.tr();
    }
    return null;
  }
}
