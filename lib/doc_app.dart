import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/routing/app_router.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:doc_app/features/dark/cubit/theme_cubit_cubit.dart';
import 'package:doc_app/core/theming/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocDoc extends StatelessWidget {
  final AppRouter appRouter;
  const DocDoc({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'DocDoc',
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              // initialRoute: Routers.localScreen,
              initialRoute: isLoggedInUser
                  ? Routers.homeScreen
                  : Routers.onboardingScreen,
              onGenerateRoute: appRouter.generateRoute,
              // builder: (context, widget) => MediaQuery(
              //   data: MediaQuery.of(
              //     context,
              //   ).copyWith(textScaler: TextScaler.linear(1.0)),
              //   child: widget!,
              // ),
            );
          },
        );
      },
    );
  }
}
