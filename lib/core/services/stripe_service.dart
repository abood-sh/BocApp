// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripeService {
//   StripeService._();

//   static final StripeService instance = StripeService._();

//   Future<void> makePayment() async {
//     try {
//       String? paymentIntentClientSecret = await _createPaymentIntent(
//         100,
//         'USD',
//       );
//       if (paymentIntentClientSecret == null) return;
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentClientSecret,
//           merchantDisplayName: 'DocApp',
//           applePay: PaymentSheetApplePay(
//             merchantCountryCode: 'US',
//             buttonType: PlatformButtonType.buy, // Use your country code
//           ),
//           googlePay: const PaymentSheetGooglePay(
//             merchantCountryCode: 'US', // Must match applePay
//             testEnv: true, // Set to false in production
//           ),
//         ),
//       );
//       await _processPayment();
//     } catch (error) {
//       print('Error initializing payment sheet: $error');
//     }
//   }

//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       Dio dio = Dio();
//       Map<String, dynamic> body = {
//         'amount': _calculateAmount(amount),
//         'currency': currency,
//       };
//       var response = await dio.post(
//         'https://api.stripe.com/v1/payment_intents',
//         data: body,
//         options: Options(
//           method: 'POST',
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization":
//                 "Bearer sk_test_51RRWNND7KPQ052f8dIdorsyJlPAPyWvKtQ0vP1zwycBCJnNgZpK0lrprk1uJ2nCisdC1nMwKfgCB87CEy687Watz00anYJaSzc", // Replace with your actual secret key
//             "Content-Type": "application/x-www-form-urlencoded",
//           },
//         ),
//       );
//       if (response != null) {
//         return response.data['client_secret'];
//       }
//       return null;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   Future<void> _processPayment() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       // Handle successful payment here
//     } catch (error) {
//       // Handle error here
//       print('Error processing payment: $error');
//     }
//   }

//   String _calculateAmount(int amount) {
//     // Convert the amount to the smallest currency unit (e.g., cents for USD)
//     return (amount * 100).toStringAsFixed(0);
//   }
// }

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
