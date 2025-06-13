import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_field.dart';
import 'have_an_account_widget.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> userNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String userName, password, email;
  late bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      userName = value!;
                    },
                    hintText: 'الاسم',
                    textInputType: TextInputType.name,
                    formKey: userNameKey,
                    onChanged: (val) {
                        userNameKey.currentState!.validate();
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomTextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    hintText: 'البريد الإلكتروني',
                    textInputType: TextInputType.emailAddress,
                    formKey: emailKey,
                    onChanged: (val) {
                      emailKey.currentState!.validate();
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  PasswordField(
                    onSaved: (value) {
                      password = value!;
                    },
                    formKey: passwordKey,
                    onChanged: (val) {
                      passwordKey.currentState!.validate();
                    },
                  ),
                  // TermsAndConditionsWidget(
                  //   onChanged: (value) {
                  //     isTermsAccepted = value;
                  //   },
                  // ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //if (isTermsAccepted) {
                          // BlocProvider.of<SignUpCubit>(context)
                          //     .createUserWithEmailAndPassword(
                          //         signUpModel: SignUpModel(
                          //   email: email,
                          //   userName: userName,
                          //   password: password,
                          //   roleName: "Customer",
                          // ));
                          // } else {
                          //   showSnackBarFun(
                          //     context: context,
                          //     text: 'يجب عليك الموافقة على الشروط والإحكام',
                          //   );
                          // }
                        //} 
                      }
                      else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                    },
                    text: 'إنشاء حساب جديد',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const HaveAnAccountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
