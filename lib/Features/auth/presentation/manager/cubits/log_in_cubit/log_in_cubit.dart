import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saree3_mobile/Features/auth/domain/repos/auth_repo.dart';

import '../../../../data/models/log_in_model.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit({required this.authRepo}) : super(LogInInitial());
  final AuthRepo authRepo;
  Future<void> logInWithEmailAndPassword(
      {required LogInModel logInModel}) async {
    emit(LoginLoadingState());
    var res = await authRepo.logInWithEmailAndPassword(
        logInModel :logInModel);
    res.fold((fail) => emit(LogInFailureState(errMessage: fail)),
        (authModel) => emit(LogInSuccessState(authModel: authModel)));
  }

}
