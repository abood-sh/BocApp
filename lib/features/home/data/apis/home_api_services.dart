import 'package:dio/dio.dart';
import 'package:doc_app/core/networking/api_constanta.dart';
import 'package:doc_app/features/home/data/apis/home_api_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../model/specializations_response_model.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl: ApiConstanta.apiBaseUrl)
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio, {String baseUrl}) = _HomeApiServices;

  @GET(HomeApiConstants.specializationEP)
  Future<List<SpecializationsData?>?> getSpecialization();
}
