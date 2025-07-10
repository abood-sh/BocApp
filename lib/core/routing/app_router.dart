import 'package:doc_app/features/chat/logic/cubit/user_cubit.dart';
import 'package:doc_app/features/chat/ui/chat_users_screen.dart';
import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doc_app/features/onboarding/onboarding_screen.dart';
import 'package:doc_app/features/sign_up/logic/cubit/signup_cubit.dart';
import 'package:doc_app/features/sign_up/ui/sign_up_screen.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_cubit.dart';
import 'package:doc_app/features/stripe_pay/stripe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/dependency_injection.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/login/ui/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.onboardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case Routers.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routers.signupScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routers.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit(getIt())..getSpecialization(),
            // same getIt<HomeCubit>() but not add   getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
            // registerFactory create new instance when go to Home cubit every time ==  HomeCubit(getIt())
            child: const HomeScreen(),
          ),
        );
      case Routers.stripeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<StripeCubit>(),
            child: const StripeScreen(),
          ),
        );
      case Routers.chatScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => UserCubit(getIt())..getUsersStream(),
            child: const ChatUsersScreen(),
          ),
        );

      default:
        null;
    }
    return null;
  }
}
