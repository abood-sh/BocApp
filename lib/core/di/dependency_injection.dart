import 'package:dio/dio.dart';
import 'package:doc/core/features/login/logic/cubit/login_cubit.dart';
import 'package:doc/core/features/sign_up/data/repo/sign_up_repo.dart';
import 'package:doc/core/features/sign_up/logic/cubit/signup_cubit.dart';
import 'package:doc/core/networking/dio_factory.dart';
import 'package:get_it/get_it.dart';

import '../features/login/data/repos/login_repos.dart';
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

}
