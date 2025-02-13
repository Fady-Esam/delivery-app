import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:saree3_mobile/core/helpers/show_snack_bar_fun.dart';

import '../../manager/cubits/sign_up_cubit/sign_up_cubit.dart';
import '../../manager/cubits/sign_up_cubit/sign_up_state.dart';
import 'signup_view_body.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          showSnackBarFun(context: context, text: "Sign Up Success");
          Navigator.pop(context);
        }
        if (state is SignUpFailureState) {
          showSnackBarFun(context: context, text: state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoadingState,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
