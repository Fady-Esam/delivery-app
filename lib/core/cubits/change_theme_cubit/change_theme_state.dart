import 'package:flutter/material.dart';

class ChangeThemeState {}

class ChangeThemeInitial extends ChangeThemeState {}

class ChangeThemeDone extends ChangeThemeState {
  final ThemeMode theme;

  ChangeThemeDone({required this.theme});
}
