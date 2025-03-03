import 'package:doc/core/routing/app_router.dart';
import 'package:doc/core/routing/routers.dart';
import 'package:doc/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocDoc extends StatelessWidget {
  final AppRouter appRouter;
  const DocDoc({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'DocDoc',
        theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: ColorsManager.white),
        debugShowCheckedModeBanner: false,
        initialRoute: Routers.onboardingScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
