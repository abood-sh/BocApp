import 'package:bloc/bloc.dart';
import 'package:doc_app/core/services/stripe_service.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_request_model.dart';
import 'package:doc_app/features/stripe_pay/data/repos/stripe_repository.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_state.dart';

class StripeCubit extends Cubit<StripeState> {
  final StripeRepository _stripeRepository;

  StripeCubit(this._stripeRepository) : super(StripeState.initial());

  Future<void> createPaymentIntent(
    int amount,
    List<String>? paymentMethodTypes,
    String customerId,
  ) async {
    emit(StripeState.loading());
    final ephemeralKeyResponse = await _stripeRepository.createEphemeralKey(
      customerId,
    );
    ephemeralKeyResponse.when(
      success: (ephemeralKeyResponseModel) async {
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
