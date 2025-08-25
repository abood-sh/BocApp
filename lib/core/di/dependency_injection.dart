import 'package:dio/dio.dart';
import 'package:doc_app/core/networking/stripe/stripe_api_service.dart';
import 'package:doc_app/core/networking/stripe/stripe_dio_factory.dart';
import 'package:doc_app/features/chat/data/repos/message_repo.dart';
import 'package:doc_app/features/chat/data/repos/user_repo.dart';
import 'package:doc_app/features/chat/logic/cubit/user_cubit.dart';
import 'package:doc_app/features/home/data/apis/home_api_services.dart';
import 'package:doc_app/features/home/data/repos/home_repo.dart';
import 'package:doc_app/features/local/cubit/locale_cubit_cubit.dart';
import 'package:doc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doc_app/features/sign_up/data/repo/sign_up_repo.dart';
import 'package:doc_app/features/sign_up/logic/cubit/signup_cubit.dart';
import 'package:doc_app/core/networking/dio_factory.dart';
import 'package:doc_app/features/stripe_pay/data/repos/stripe_repository.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/login/data/repos/login_repos.dart';
import '../networking/api_service.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // dio & api service
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
  // home
  getIt.registerLazySingleton<HomeApiServices>(() => HomeApiServices(dio));
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getIt()..getSpecialization()),
  );

  // Firebase Services
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<MessageRepository>(() => MessageRepository());
  getIt.registerFactory<UserCubit>(() => UserCubit(getIt<UserRepository>()));

  // stripe services
  // Add to your existing DI setup
  Dio dio_stripe = StripeDioFactory.getDio();

  getIt.registerLazySingleton<StripeApiService>(
    () => StripeApiService(dio_stripe),
  );

  getIt.registerLazySingleton(() => StripeRepository(getIt()));
  getIt.registerFactory<StripeCubit>(() => StripeCubit(getIt()));

  // locale
  final savedLocale = await LocaleCubit.getSavedLocale();
  getIt.registerFactory<LocaleCubit>(() => LocaleCubit(savedLocale));
}
