import 'package:doc_app/core/networking/stripe/stripe_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_api_result.freezed.dart';

@freezed
class StripeApiResult<T> with _$StripeApiResult<T> {
  const factory StripeApiResult.success(T data) = Success<T>;
  const factory StripeApiResult.failure(StripeErrorModel stripeErrorModel) =
      Failure<T>;

  const StripeApiResult._();
}
