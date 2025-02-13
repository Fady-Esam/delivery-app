import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:saree3_mobile/Features/auth/presentation/manager/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:saree3_mobile/Features/auth/presentation/manager/cubits/log_in_cubit/log_in_state.dart';
import 'package:saree3_mobile/core/helpers/show_snack_bar_fun.dart';


import '../../../../../core/widgets/custom_progress_hud.dart';
import 'signin_view_body.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInSuccessState) {
          //Navigator.pushNamed(context, MainView.routeName);
          showSnackBarFun(context: context, text: "Log In Success");
        }

        if (state is LogInFailureState) {
          showSnackBarFun(context: context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is LoginLoadingState ,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
