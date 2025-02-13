
import 'package:saree3_mobile/Features/auth/data/models/auth_model.dart';

class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String errMessage;
  SignUpFailureState({required this.errMessage});
}

class SignUpSuccessState extends SignUpState {
    final AuthModel authModel;

  SignUpSuccessState({required this.authModel});
}

class SignUpLoadingState extends SignUpState {

}




