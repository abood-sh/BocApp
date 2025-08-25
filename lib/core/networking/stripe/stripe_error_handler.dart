import 'package:dio/dio.dart';
import 'package:doc_app/core/networking/stripe/stripe_error_model.dart';

class StripeErrorHandler {
  static StripeErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return StripeErrorModel(
            error: StripeErrors(message: "Connection to server failed"),
          );
        case DioExceptionType.cancel:
          return StripeErrorModel(
            error: StripeErrors(message: "Request to the server was cancelled"),
          );
        case DioExceptionType.connectionTimeout:
          return StripeErrorModel(
            error: StripeErrors(message: "Connection timeout with the server"),
          );
        case DioExceptionType.unknown:
          return StripeErrorModel(
            error: StripeErrors(
              message:
                  "Connection to the server failed due to internet connection",
            ),
          );
        case DioExceptionType.receiveTimeout:
          return StripeErrorModel(
            error: StripeErrors(
              message: "Receive timeout in connection with the server",
            ),
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return StripeErrorModel(
            error: StripeErrors(
              message: " Send timeout in connection with the server",
            ),
          );
        default:
          return StripeErrorModel(
            error: StripeErrors(message: "Something went wrong"),
          );
      }
    } else {
      return StripeErrorModel(
        error: StripeErrors(message: "Unknown error occurred"),
      );
    }
  }
}

StripeErrorModel _handleError(dynamic data) {
  if (data is Map<String, dynamic>) {
    // Handle standard Stripe error response format
    if (data.containsKey('error') && data['error'] is Map<String, dynamic>) {
      return StripeErrorModel.fromJson(data);
    }
    // Fallback to direct message/type extraction
    return StripeErrorModel(
      error: StripeErrors(
        message: data['message']?.toString() ?? 'Unknown error occurred',
        type: data['type']?.toString(),
      ),
    );
  } else if (data is String) {
    return StripeErrorModel(error: StripeErrors(message: data));
  } else {
    return StripeErrorModel(
      error: StripeErrors(message: 'Unknown error occurred'),
    );
  }
}
