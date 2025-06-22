import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Text(
            'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
            style: TextStyles.font13GrayRegular,
            textAlign: TextAlign.center,
          ),
          verticalSpace(10.h),
          TextButton(
            onPressed: () {
              context.pushNamed(Routers.loginScreen);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                ColorsManager.mainBlue,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 52),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            child: Text("Get Started", style: TextStyles.font16WhiteMedium),
          ),
        ],
      ),
    );
  }
}
