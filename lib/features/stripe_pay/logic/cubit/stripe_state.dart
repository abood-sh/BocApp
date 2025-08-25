import 'package:doc_app/core/networking/api_error_model.dart';
import 'package:doc_app/core/networking/stripe/stripe_error_handler.dart';
import 'package:doc_app/core/networking/stripe/stripe_error_model.dart';
import 'package:doc_app/features/stripe_pay/data/model/stripe_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_state.freezed.dart';

@freezed
class StripeState with _$StripeState {
  const factory StripeState.initial() = _Initial;
  const factory StripeState.loading() = Loading;
  const factory StripeState.success(StripeResponseModel response) = Success;
  const factory StripeState.error(StripeErrorModel stripeErrorModel) = Error;
}
