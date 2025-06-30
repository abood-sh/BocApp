import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/networking/dio_factory.dart';
import 'package:doc_app/features/login/data/models/login_req_body.dart';
import 'package:doc_app/features/login/logic/cubit/login_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doc_app/features/login/data/repos/login_repos.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginReqBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (loginResponse) async {
        await saveUserToken(loginResponse.userData?.token ?? "");
        emit(LoginState.success(loginResponse));
      },
      failure: (apiErrorModel) {
        emit(LoginState.error(apiErrorModel));
      },
    );
  }

  saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
