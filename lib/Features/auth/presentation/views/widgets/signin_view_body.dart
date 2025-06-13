import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/phone_number_view.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/widgets/or_divider.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../../../../../core/helpers/custom_login_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_field.dart';
import 'dont_have_account_widget.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, phonNumber;
  late String password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
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
                      email = value!;
                    },
                    hintText: 'البريد الالكتروني',
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
                    isLogIn: true,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PhoneNumberView.routeName,
                        arguments: {
                          'buttonTitle': 'نسيت كلمة المرور',
                          'description':
                              'رجاء ادخل رقم الهاتف لنتمكن من ارسال رمز التحقق لك و تأكد من كتابة رقم الهاتف بشكل صحيح',
                          'title': 'نسيان كلمة المرور',
                          'onClickBtn': (String phoneNumber) {
                            // logic Here
                          }
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyles.semiBold13.copyWith(
                            color: AppColors.primaryColor,
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //context.read<SigninCubit>().signin(email, password);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text: 'تسجيل دخول',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  const DontHaveAnAccountWidget(),
                  SizedBox(
                    height: 32.h,
                  ),
                  const OrDivider(),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomLoginButton(
                    image: Assets.imagesGoogleIcon,
                    labelText: 'تسجيل بواسطة جوجل',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  /*Platform.isIOS
                      ?*/
                  Column(
                    children: [
                      CustomLoginButton(
                        onPressed: () {
                          //context.read<SigninCubit>().signinWithApple();
                        },
                        image: Assets.imagesApplIcon,
                        labelText: 'تسجيل بواسطة أبل',
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
