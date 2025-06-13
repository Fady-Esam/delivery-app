import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saree3_mobile/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:saree3_mobile/Features/auth/presentation/manager/cubits/sign_up_cubit/sign_up_cubit.dart';


import '../../../../core/services/api_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'widgets/signup_view_body_bloc_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        authRepo: AuthRepoImpl(apiService: ApiService())
      ),
      child: Scaffold(
        appBar: AppBar(
        title: Text(
          "حساب جديد",
          style: TextStyles.bold23,
        ),
        centerTitle: true,
      ),
        body: const SignupViewBodyBlocConsumer(),
      ),
    );
  }
}
