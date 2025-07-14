import 'package:doc_app/features/login/data/models/login_req_body.dart';
import 'package:doc_app/core/networking/api_result.dart';
import 'package:doc_app/core/networking/api_service.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../models/login_res_body.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(LoginReqBody loginReqBody) async {
    try {
      final response = await _apiService.login(loginReqBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
