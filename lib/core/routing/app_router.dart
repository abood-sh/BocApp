import 'package:doc/core/features/onbording/onboarding_screen.dart';
import 'package:doc/core/routing/routers.dart';
import 'package:flutter/material.dart';

import '../features/login/ui/login_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.onboardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routers.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      // case Routers.registerScreen: // Add the signup route case
      //   return MaterialPageRoute(builder: (context) => const SignupScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
