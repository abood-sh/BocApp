import 'package:doc_app/core/networking/api_error_handler.dart';
import 'package:doc_app/core/networking/api_result.dart';
import 'package:doc_app/core/networking/stripe/stripe_api_result.dart';
import 'package:doc_app/core/networking/stripe/stripe_api_service.dart';
import 'package:doc_app/core/networking/stripe/stripe_error_handler.dart';
import 'package:doc_app/features/stripe_pay/data/model/create_customer_reqest_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/create_customer_response_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/ephemeral_key_response_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_request_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_response_model.dart';

class StripeRepository {
  final StripeApiService _stripeApiService;

  StripeRepository(this._stripeApiService);

  Future<StripeApiResult<StripeResponseModel>> createPaymentIntent(
    StripeRequestModel stripeRequestModel,
  ) async {
    try {
      final response = await _stripeApiService.createPaymentIntent(
        stripeRequestModel,
      );
      return StripeApiResult.success(response);
    } catch (error) {
      return StripeApiResult.failure(StripeErrorHandler.handle(error));
    }
  }

  Future<StripeApiResult<EphemeralKeyResponseModel>> createEphemeralKey(
    String customerId,
  ) async {
    try {
      final response = await _stripeApiService.createEphemeralKey(customerId);
      return StripeApiResult.success(response);
    } catch (error) {
      return StripeApiResult.failure(StripeErrorHandler.handle(error));
    }
  }

  Future<StripeApiResult<CreateCustomerResponseModel>> createCustomer(
    CreateCustomerRequestModel createCustomerRequestModel,
  ) async {
    try {
      final response = await _stripeApiService.createCustomer(
        createCustomerRequestModel,
      );
      return StripeApiResult.success(response);
    } catch (error) {
      return StripeApiResult.failure(StripeErrorHandler.handle(error));
    }
  }
}
