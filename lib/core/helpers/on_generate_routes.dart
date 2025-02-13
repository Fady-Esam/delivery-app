import 'package:flutter/material.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/choose_view.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/signin_view.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/signup_view.dart';

import '../../Features/auth/presentation/views/add_image_view.dart';
import '../../Features/auth/presentation/views/phone_number_view.dart';
import '../../Features/auth/presentation/views/reset_password_view.dart';
import '../views/custom_verify_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ResetPasswordView.routeName:
      return MaterialPageRoute(builder: (context) => const ResetPasswordView());
    case PhoneNumberView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => PhoneNumberView(
          buttonTitle: args['buttonTitle'] as String,
          description: args['description'] as String,
          title: args['title'] as String,
          onClickBtn: args['onClickBtn'] as void Function(String),
        ),
      );
    case CustomVerifyView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(builder: (context) => CustomVerifyView(
        phoneNumber: args['phoneNumber'] as String,
        isFromForgottonPassword: args['isFromForgottonPassword'] as bool,
      ));
    case ChooseView.routeName:
      return MaterialPageRoute(builder: (context) => const ChooseView());
    case AddImageView.routeName:
      return MaterialPageRoute(builder: (context) => const AddImageView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
