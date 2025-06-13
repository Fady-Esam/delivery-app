import 'package:flutter/material.dart';

class ChangeLanguageState {}

class ChangeLanguageInitial extends ChangeLanguageState {}

class ChangeLanguageDone extends ChangeLanguageState {
  final Locale language;
  ChangeLanguageDone({required this.language});
}