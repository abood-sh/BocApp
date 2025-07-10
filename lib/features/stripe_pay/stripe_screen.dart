// import 'package:doc_app/core/services/stripe_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripeScreen extends StatelessWidget {
//   const StripeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Stripe Payment')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await StripeService.instance.makePayment();
//             print("gggggg");
//           },
//           child: Text('Pay with Stripe'),
//         ),
//       ),
//     );
//   }
// }

import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:doc_app/core/services/stripe_service.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/core/widget/app_text_button.dart';
import 'package:doc_app/features/stripe_pay/data/repos/stripe_repository.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_cubit.dart';
import 'package:doc_app/features/stripe_pay/logic/cubit/stripe_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StripeScreen extends StatelessWidget {
  const StripeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment')),
      body: BlocConsumer<StripeCubit, StripeState>(
        listenWhen: (previous, current) =>
            current is Loading || current is Success || current is Error,
        listener: (context, state) async {
          state.whenOrNull(
            loading: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Processing payment...'),
                  backgroundColor:
                      ColorsManager.mainBlue, // Set your desired color
                  behavior:
                      SnackBarBehavior.floating, // or SnackBarBehavior.fixed
                ),
              );
            },
            success: (response) async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment Success'),
                  backgroundColor:
                      ColorsManager.green, // Set your desired color
                  behavior:
                      SnackBarBehavior.floating, // or SnackBarBehavior.fixed
                ),
              );
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.message ?? 'Payment failed'),
                  backgroundColor: ColorsManager.red, // Set your desired color
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
        buildWhen: (previous, current) =>
            current is Loading || current is Success || current is Error,
        builder: (context, state) {
          return state.maybeWhen(
            initial: () => Center(
              child: AppTextButton(
                buttonWidth: 300,
                buttonText: "Pay Now",
                textStyle: TextStyles.font16WhiteMedium,
                onPressed: () async {
                  state is Loading
                      ? null
                      : await context.read<StripeCubit>().createPaymentIntent(
                          100,
                          [],
                          'cus_SeaNA2BTVhwYju',
                        );
                },
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (response) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Payment Successful',
                      style: TextStyle(
                        color: ColorsManager.green,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            },
            error: (error) =>
                Center(child: Text(error.message ?? 'An error occurred')),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
