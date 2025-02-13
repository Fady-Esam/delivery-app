import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
    this.validatePassword,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final String? Function(String?)? validatePassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      validator: hintText == "كلمة المرور" || hintText == "تأكيد كلمة المرور" ? validatePassword :  (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (textInputType == TextInputType.emailAddress &&
            !isValidEmail(value)) {
          return 'بريد الكتروني غير صالح';
        }
        if (textInputType == TextInputType.phone &&
            !(RegExp(r'^01[0|1|2|5][0-9]{8}$')).hasMatch(value)) {
          return 'رقم هاتف غير صالح';
        }
        if (textInputType == TextInputType.name &&
            (value.trim().length < 3 || value.trim().length > 20)) {
          return 'الاسم يجب الا يقل عن 3 ولا يزيد عن 20';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintStyle: TextStyles.bold13.copyWith(
          color: const Color(0xFF949D9E),
        ),
        hintText: hintText,
        filled: true,
        fillColor: Color.fromARGB(10, 128, 128, 128),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Email format regex
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // List of disposable email domains
    final disposableDomains = [
      "10minutemail.com",
      "mailinator.com",
      "guerrillamail.com",
      "yopmail.com",
      "temp-mail.org",
      "throwawaymail.com",
      "fakeinbox.com",
      "trashmail.com",
      "maildrop.cc",
      "dispostable.com",
      "tempmailaddress.com",
      "getnada.com",
      "mailnesia.com",
      "mytemp.email",
      "tempail.com",
      "mailcatch.com",
      "mail.bccto.me",
      "33mail.com",
      "harakirimail.com",
      "mail.tm"
    ];
    if (!emailRegex.hasMatch(email)) {
      return false; // Invalid email format
    }

    // Extract domain from the email
    final domain = email.split('@').last;

    // Check if the domain is in the disposable domains list
    if (disposableDomains.contains(domain)) {
      return false; // Disposable email detected
    }

    return true; // Email is valid and not disposable
  }
}
