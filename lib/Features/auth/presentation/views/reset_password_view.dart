import 'package:flutter/material.dart';
import 'package:saree3_mobile/core/widgets/custom_button.dart';
import 'package:saree3_mobile/core/widgets/password_field.dart';

import '../../../../core/utils/app_text_styles.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  static const String routeName = "resetPassword";
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  String? password, confirmPassword;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "كلمة مرور جديدة",
          style: TextStyles.bold23,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22,
              ),
              Text(
                "قم بإنشاء كلمة مرور جديدة لتسجيل الدخول",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 30, 25, 25),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              PasswordField(
                onSaved: (value) {
                  confirmPassword = value;
                },
                hintText: "تأكيد كلمة المرور",
                validateConfirmedPassword: (value) {
                  if (password != value) {
                    return "كلمة المرور غير متطابقة";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 28,
              ),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // Reset of Logic
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: "إنشاء كلمة مرور جديدة",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
