import 'package:doc_app/core/networking/api_error_handler.dart';
import 'package:doc_app/core/networking/api_result.dart';
import 'package:doc_app/core/networking/stripe_api_service.dart';
import 'package:doc_app/features/stripe_pay/data/model/ephemeral_key_response_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_request_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_response_model.dart';

class StripeRepository {
  final StripeApiService _stripeApiService;

  StripeRepository(this._stripeApiService);

  Future<ApiResult<StripeResponseModel>> createPaymentIntent(
    StripeRequestModel stripeRequestModel,
  ) async {
    try {
      final response = await _stripeApiService.createPaymentIntent(
        stripeRequestModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<EphemeralKeyResponseModel>> createEphemeralKey(
    String customerId,
  ) async {
    try {
      final response = await _stripeApiService.createEphemeralKey(customerId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
