
import 'package:saree3_mobile/Features/auth/data/models/auth_model.dart';

class LogInState {}

class LogInInitial extends LogInState {}


class LogInFailureState extends LogInState {
  final String errMessage;
  LogInFailureState({required this.errMessage});
}

class LogInSuccessState extends LogInState {
  final AuthModel authModel;

  LogInSuccessState({required this.authModel});
}

class LoginLoadingState extends LogInState {}



