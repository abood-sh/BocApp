class StripeErrorModel {
  final StripeErrors error;

  StripeErrorModel({required this.error});

  factory StripeErrorModel.fromJson(Map<String, dynamic> json) {
    return StripeErrorModel(error: StripeErrors.fromJson(json['error']));
  }
}

class StripeErrors {
  final String message;
  final String? type;

  StripeErrors({required this.message, this.type});

  factory StripeErrors.fromJson(Map<String, dynamic> json) {
    return StripeErrors(
      message: json['message'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
