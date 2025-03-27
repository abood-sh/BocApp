import 'package:doc/core/di/dependency_injection.dart';
import 'package:doc/core/routing/app_router.dart';
import 'package:doc/doc_app.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  setupGetIt();
  runApp(DocDoc(
    appRouter: AppRouter(),
  ));
}
