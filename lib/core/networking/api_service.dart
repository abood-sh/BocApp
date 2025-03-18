import 'package:dio/dio.dart';
import 'package:doc/core/features/login/data/models/login_req_body.dart';
import 'package:doc/core/networking/api_constanta.dart';
import 'package:retrofit/retrofit.dart';

import '../features/login/data/models/login_res_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstanta.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstanta.login)
  Future<LoginResponse> login(
    @Body() LoginReqBody loginReqBody,
  );
}
