class StripeRequestModel {
  final int amount;
  final String currency;
  final List<String>? paymentMethodTypes;
  final String? customerId;

  StripeRequestModel({
    required this.amount,
    required this.currency,
    this.paymentMethodTypes,
    required this.customerId,
  });

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'currency': currency,
    'payment_method_types[]': paymentMethodTypes,
    'customer': customerId,
  };
}
