import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saree3_mobile/Features/auth/presentation/manager/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/phone_number_view.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/widgets/or_divider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../data/models/log_in_model.dart';
import 'custom_email_or_phone_options.dart';
import 'dont_have_account_widget.dart';
import 'social_login_button.dart';

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
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PhoneNumberView.routeName,
                    arguments: {
                      'buttonTitle': 'نسيت كلمة المرور',
                      'description': 'رجاء ادخل رقم الهاتف لنتمكن من ارسال رمز التحقق لك و تأكد من كتابة رقم الهاتف بشكل صحيح',
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 33,
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
              const SizedBox(
                height: 33,
              ),
              const DontHaveAnAccountWidget(),
              const SizedBox(
                height: 33,
              ),
              const OrDivider(),
              const SizedBox(
                height: 16,
              ),
              SocialLoginButton(
                onPressed: () async {
                  // await BlocProvider.of<LogInCubit>(context)
                  //     .logInWithEmailAndPassword(
                  //         logInModel: LogInModel(
                  //   password: password,
                  //   email: email,
                  //   phoneNumber: phonNumber,
                  // ));
                },
                image: Assets.imagesGoogleIcon,
                title: 'تسجيل بواسطة جوجل',
              ),
              const SizedBox(
                height: 16,
              ),
              /*Platform.isIOS
                  ?*/
              Column(
                children: [
                  SocialLoginButton(
                    onPressed: () {
                      //context.read<SigninCubit>().signinWithApple();
                    },
                    image: Assets.imagesApplIcon,
                    title: 'تسجيل بواسطة أبل',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ) /*: const SizedBox()*/,
              // SocialLoginButton(
              //   onPressed: () {
              //     //context.read<SigninCubit>().signinWithFacebook();
              //   },
              //   image: Assets.imagesFacebookIcon,
              //   title: 'تسجيل بواسطة فيسبوك',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
