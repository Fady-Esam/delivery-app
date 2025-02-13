import 'package:dartz/dartz.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/log_in_model.dart';
import '../../data/models/sign_up_model.dart';

abstract class AuthRepo {
  Future<Either<String, AuthModel>> logInWithEmailAndPassword(
      {required LogInModel logInModel});
  Future<Either<String, AuthModel>> signUpWithEmailAndPassword(
      {required SignUpModel signUpModel});
}
