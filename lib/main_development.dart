import 'package:doc_app/core/di/dependency_injection.dart';
import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/routing/app_router.dart';
import 'package:doc_app/core/services/notifications.dart';
import 'package:doc_app/features/dark/cubit/theme_cubit_cubit.dart';
import 'package:doc_app/doc_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  await NotificationService().initialize();
  await EasyLocalization.ensureInitialized();
  final initialTheme = await ThemeCubit.getInitialMode();
  Stripe.publishableKey =
      "pk_test_51RRWNND7KPQ052f807yzxmIZBvWfF3e46OzpvigsqxanG0Uv9awAPEDN0AjZxE1Y3VkRkmR5T7p7dMXrAlE3jFzD00y2C6h5cJ";
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();
  await setupGetIt();
  // await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: BlocProvider(
        create: (context) => ThemeCubit(initialTheme),
        child: DocDoc(appRouter: AppRouter()),
      ),
    ),
  );
}

checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
