
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/sign_up_model.dart';
import '../../../../domain/repos/auth_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());
  final AuthRepo authRepo;
  Future<void> createUserWithEmailAndPassword(
      {required SignUpModel signUpModel}) async {
    emit(SignUpLoadingState());
    var res = await authRepo.signUpWithEmailAndPassword(
        signUpModel: signUpModel);
    res.fold((fail) => emit(SignUpFailureState(errMessage: fail)),
        (authModel) => emit(SignUpSuccessState(authModel: authModel)));
  }

}
