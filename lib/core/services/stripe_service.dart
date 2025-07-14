import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> initializePaymentSheet({
    String? clientSecret,
    required String customerEphemeralKeySecret,
    String? customerId,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'DocApp',
        customerId: customerId,
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        applePay: PaymentSheetApplePay(
          merchantCountryCode: 'US',
          buttonType: PlatformButtonType.buy,
        ),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'US',
          currencyCode: 'USD',
          testEnv: true,
        ),
        style: ThemeMode.dark,
        appearance: PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            primary: Colors.blue, // Set your brand color
          ),
        ), // Use system theme
      ),
    );
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
