
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitial());
  bool isDarkTheme = false;
  void changeTheme({required bool isDark}){
    isDarkTheme = isDark;
    emit(ChangeThemeDone());
  }
}
