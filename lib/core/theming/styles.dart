import 'package:doc_app/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// | displayLarge   | 57.0 |   64.0  | regular | -0.25    |             |
/// | displayMedium  | 45.0 |   52.0  | regular |  0.0     |             |
/// | displaySmall   | 36.0 |   44.0  | regular |  0.0     |             |
/// | headlineLarge  | 32.0 |   40.0  | regular |  0.0     |             |
/// | headlineMedium | 28.0 |   36.0  | regular |  0.0     |             |
/// | headlineSmall  | 24.0 |   32.0  | regular |  0.0     |             |
/// | titleLarge     | 22.0 |   28.0  | regular |  0.0     |             |
/// | titleMedium    | 16.0 |   24.0  | medium  |  0.15    |             |
/// | titleSmall     | 14.0 |   20.0  | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 |   24.0  | regular |  0.5     |             |
/// | bodyMedium     | 14.0 |   20.0  | regular |  0.25    |             |
/// | bodySmall      | 12.0 |   16.0  | regular |  0.4     |             |
/// | labelLarge     | 14.0 |   20.0  | medium  |  0.1     |             |
/// | labelMedium    | 12.0 |   16.0  | medium  |  0.5     |             |
/// | labelSmall     | 11.0 |   16.0  | medium  |  0.5     |
class TextStyles {
  static TextStyle font24BlackBold(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  static TextStyle font32BlueBold(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(
      fontSize: 32.sp,
      fontWeight: FontWeightHelper.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font13BlueSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font13DarkBlueMedium(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.medium,
    );
  }

  static TextStyle font13DarkBlueRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
    );
  }

  static TextStyle font24BlueBold(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font16WhiteSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.white,
    );
  }

  static TextStyle font14WhiteSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.white,
    );
  }

  static TextStyle font8GrayRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
      fontSize: 8.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).disabledColor,
    );
  }

  static TextStyle font13GrayRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).disabledColor,
    );
  }

  static TextStyle font12GrayRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).disabledColor,
    );
  }

  static TextStyle font12GrayMedium(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.medium,
      color: Theme.of(context).disabledColor,
    );
  }

  static TextStyle font12DarkBlueRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
    );
  }

  static TextStyle font12BlueRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font13BlueRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!.copyWith(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font14GrayRegular(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).disabledColor,
    );
  }

  static TextStyle font14LightGrayRegular(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).hintColor,
    );
  }

  static TextStyle font14DarkBlueMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.medium,
    );
  }

  static TextStyle font14DarkBlueBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.bold,
    );
  }

  static TextStyle font16WhiteMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.white,
    );
  }

  static TextStyle font14BlueSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle font15DarkBlueMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
      fontSize: 15.sp,
      fontWeight: FontWeightHelper.medium,
    );
  }

  static TextStyle font18DarkBlueBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.bold,
    );
  }

  static TextStyle font19DarkBlueBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 19.sp,
      fontWeight: FontWeightHelper.bold,
    );
  }

  static TextStyle font18DarkBlueSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.semiBold,
    );
  }

  static TextStyle font18WhiteMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.white,
    );
  }
}
