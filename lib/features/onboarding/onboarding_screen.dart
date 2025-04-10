import 'package:doc/features/onboarding/widget/doc_logo_name.dart';
import 'package:doc/features/onboarding/widget/doctor_image_and_text.dart';
import 'package:doc/features/onboarding/widget/get_started.dart';
import 'package:doc/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            child: Column(
              children: [
                const DocLogoAndName(),
                verticalSpace(30.h),
                const DoctorNameAndText(),
                const GetStartedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
