import 'package:bloc/bloc.dart';
import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/services/stripe_service.dart';
import 'package:doc_app/features/stripe_pay/data/model/create_customer_reqest_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_request_model.dart';
import 'package:doc_app/features/stripe_pay/data/repos/stripe_repository.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_state.dart';

class StripeCubit extends Cubit<StripeState> {
  final StripeRepository _stripeRepository;

  StripeCubit(this._stripeRepository) : super(StripeState.initial());

  Future<void> createPaymentIntent(
    int amount,
    List<String>? paymentMethodTypes,
    // String? customerId,
  ) async {
    /// Create a customer if not exists
    // Retrieve customerId from shared preferences
    String? customerId = await SharedPrefHelper.getString("customerId");
    emit(StripeState.loading());
    if (customerId.isNullOrEmpty()) {
      final createCustomerResponse = await _stripeRepository.createCustomer(
        CreateCustomerRequestModel(
          email:
              "abood_shabab@hotmail.com", // Replace with actual email user like in sharedPreferences
          name:
              "Abdelrahman", // Replace with actual name user like in sharedPreferences
        ),
      );
      createCustomerResponse.when(
        success: (createCustomerResponseModel) async {
          customerId = createCustomerResponseModel.id;
          SharedPrefHelper.setData("customerId", customerId);
          print(customerId);
        },
        failure: (error) {
          emit(StripeState.error(error));
          return;
        },
      );
    }

    /// Create an ephemeral key for the customer
    final ephemeralKeyResponse = await _stripeRepository.createEphemeralKey(
      customerId!,
    );
    ephemeralKeyResponse.when(
      success: (ephemeralKeyResponseModel) async {
        /// Initialize the payment sheet with the client secret and ephemeral key
        final result = await _stripeRepository.createPaymentIntent(
          StripeRequestModel(
            paymentMethodTypes: paymentMethodTypes,
            amount: amount * 100,
            currency: 'USD',
            customerId: customerId,
          ),
        );
        result.when(
          success: (response) async {
            await StripeService.instance.initializePaymentSheet(
              clientSecret: response.clientSecret,
              customerEphemeralKeySecret: ephemeralKeyResponseModel.secret,
              customerId: customerId,
            );
            await StripeService.instance.presentPaymentSheet();
            emit(StripeState.success(response));
          },
          failure: (error) => emit(StripeState.error(error)),
        );
      },
      failure: (error) => emit(StripeState.error(error)),
    );
  }
}
