import 'package:doc_app/core/theming/colors.dart';
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
        // applePay: PaymentSheetApplePay(
        //   merchantCountryCode: 'US',
        //   buttonType: PlatformButtonType.buy,
        // ),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'UK',
          testEnv: true,
        ),
        style: ThemeMode.light,
        appearance: PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            background: ColorsManager.moreLightBlue,
            primary: ColorsManager.mainBlue,
            componentBorder: ColorsManager.gray,
          ),
          shapes: PaymentSheetShape(
            borderWidth: 2,
            shadow: PaymentSheetShadowParams(color: Colors.red),
          ),
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: Color.fromARGB(255, 231, 235, 30),
                text: Color.fromARGB(255, 235, 92, 30),
                border: Color.fromARGB(255, 235, 92, 30),
              ),
            ),
          ),
        ), // Use system theme
      ),
    );
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
