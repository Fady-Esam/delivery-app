import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saree3_mobile/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:saree3_mobile/Features/auth/presentation/manager/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:saree3_mobile/core/services/api_service.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(
        authRepo: AuthRepoImpl(apiService: ApiService())
      ),
      child: Scaffold(
        appBar: AppBar(
        title: Text(
          "تسجيل دخول",
          style: TextStyles.bold23,
        ),
        centerTitle: true,
      ),
        body: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
