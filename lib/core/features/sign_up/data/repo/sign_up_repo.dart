
import 'package:doc/core/features/sign_up/data/model/signup_req_body.dart';
import 'package:doc/core/networking/api_result.dart';

import '../../../../networking/api_error_handler.dart';
import '../../../../networking/api_service.dart';
import '../model/signup_res.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.register(signupRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
