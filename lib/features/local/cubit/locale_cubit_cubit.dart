import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(Locale initialLocale) : super(initialLocale);

  // void changeLocale(BuildContext context, Locale locale) async {
  //   await context.setLocale(locale);
  //   emit(locale);
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('locale', locale.languageCode);
  // }

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'en';
    return Locale(langCode);
  }

  void changeLanguage(Locale locale) {
    emit(locale);
  }
}
