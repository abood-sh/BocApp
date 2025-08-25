// lib/features/dark/cubit/theme_cubit_cubit.dart
import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(ThemeMode initialMode) : super(initialMode);

  static Future<ThemeMode> getInitialMode() async {
    final mode = await SharedPrefHelper.getString(SharedPrefKeys.themeKey);
    if (mode == 'light') return ThemeMode.light;
    if (mode == 'dark') return ThemeMode.dark;
    if (mode == 'system') return ThemeMode.system;
    return ThemeMode.system;
  }

  Future<void> setLightTheme() async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeKey, 'light');
    emit(ThemeMode.light);
  }

  Future<void> setDarkTheme() async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeKey, 'dark');
    emit(ThemeMode.dark);
  }

  Future<void> setSystemTheme() async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeKey, 'system');
    emit(ThemeMode.system);
  }
}
