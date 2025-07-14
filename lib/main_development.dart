import 'package:doc_app/core/di/dependency_injection.dart';
import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/routing/app_router.dart';
import 'package:doc_app/doc_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = String.fromEnvironment('PUBLISHABLE_KEY');
  Stripe.merchantIdentifier = 'pmd_1RkO6yD7KPQ052f8X9ochQb7';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();

  runApp(DocDoc(appRouter: AppRouter()));
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
