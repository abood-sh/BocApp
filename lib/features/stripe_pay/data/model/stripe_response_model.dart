class StripeResponseModel {
  final String clientSecret;
  final String? ephemeralKey; // Optional if using ephemeral key

  StripeResponseModel({required this.clientSecret, this.ephemeralKey});

  factory StripeResponseModel.fromJson(Map<String, dynamic> json) {
    return StripeResponseModel(
      clientSecret: json['client_secret'] as String,
      ephemeralKey: json['ephemeral_key'] as String?,
    );
  }
}
