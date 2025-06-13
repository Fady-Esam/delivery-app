import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';
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
  var passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmPasswordKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "كلمة مرور جديدة",
          style: TextStyles.bold23
              .copyWith(fontSize: getResponsiveFontSize(context, fontSize: 23)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      "قم بإنشاء كلمة مرور جديدة لتسجيل الدخول",
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 18),
                        color: Color.fromARGB(255, 30, 25, 25),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    PasswordField(
                      onSaved: (value) {
                        password = value;
                      },
                      textController: passwordController,
                      onChanged: (val) {
                        passwordKey.currentState!.validate();
                      },
                      formKey: passwordKey,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    PasswordField(
                      onSaved: (value) {
                        confirmPassword = value;
                      },
                      onChanged: (val) {
                        confirmPasswordKey.currentState!.validate();
                      },
                      formKey: confirmPasswordKey,
                      hintText: "تأكيد كلمة المرور",
                      validateConfirmedPassword: (value) {
                        if (passwordController.text != value 
                            ) {
                          return "كلمة المرور غير متطابقة";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: isTablet ? MediaQuery.sizeOf(context).width * 0.75 : MediaQuery.sizeOf(context).width * 0.9,
                        child: CustomButton(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
