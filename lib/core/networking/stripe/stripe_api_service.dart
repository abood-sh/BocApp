import 'package:dio/dio.dart' as dio;
import 'package:doc_app/features/stripe_pay/data/model/create_customer_reqest_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/create_customer_response_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/ephemeral_key_response_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_request_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'stripe_api_service.g.dart';

@RestApi(baseUrl: 'https://api.stripe.com/v1/')
abstract class StripeApiService {
  factory StripeApiService(Dio dioInstance) = _StripeApiService;

  @POST('payment_intents')
  Future<StripeResponseModel> createPaymentIntent(
    @Body() StripeRequestModel stripeRequestModel,
  );

  @POST('ephemeral_keys')
  @Headers({
    'Stripe-Version': '2025-04-30.basil', // Add required version header
  })
  Future<EphemeralKeyResponseModel> createEphemeralKey(
    @Field('customer') String customerId,
  );

  @POST('customers')
  Future<CreateCustomerResponseModel> createCustomer(
    @Body() CreateCustomerRequestModel createCustomerRequestModel,
  );
}
