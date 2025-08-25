import 'package:doc_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doc_app/features/dark/cubit/theme_cubit_cubit.dart';
import 'package:doc_app/core/theming/colors.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text('Theme Settings')),
            body: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(
                    '🌞 Light Mode',
                    style: TextStyles.font18DarkBlueSemiBold(context),
                  ),
                  value: ThemeMode.light,
                  // fillColor: WidgetStatePropertyAll(ColorsManager.black),
                  groupValue: themeMode,
                  onChanged: (mode) => themeCubit.setLightTheme(),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(
                    '🌙 Dark Mode',
                    style: TextStyles.font18DarkBlueSemiBold(context),
                  ),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (mode) => themeCubit.setDarkTheme(),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(
                    '🖥️ System Default',
                    style: TextStyles.font18DarkBlueSemiBold(context),
                  ),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (mode) => themeCubit.setSystemTheme(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
