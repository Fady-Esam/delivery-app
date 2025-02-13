import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    this.hintText = 'كلمة المرور',
    this.validateConfirmedPassword,
  });

  final void Function(String?)? onSaved;
  final String hintText;

  final String? Function(String?)? validateConfirmedPassword;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obscureText: obscureText,
      onSaved: widget.onSaved,
      validatePassword: widget.hintText == "كلمة المرور" ?  (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return validatePassword(value);
      } : widget.validateConfirmedPassword,
      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: obscureText
            ? const Icon(
                Icons.remove_red_eye,
                color: Color(0xffC9CECF),
              )
            : const Icon(
                Icons.visibility_off,
                color: Color(0xffC9CECF),
              ),
      ),
      hintText: widget.hintText,
      textInputType: TextInputType.visiblePassword,
    );
  }

  String? validatePassword(String password) {
    if (password.length < 8) {
      return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل (مثل @ أو #)';
    }

    return null; // كلمة المرور صحيحة
  }
}
