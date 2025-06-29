import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/colors.dart';

class DoctorsShimmerLoading extends StatelessWidget {
  const DoctorsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 8,
        separatorBuilder: (_, __) => verticalSpace(16),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: ColorsManager.lightGray,
            highlightColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.lightGray.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar shimmer
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGray,
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpace(16),
                  // Info shimmer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name shimmer
                        Container(
                          height: 18.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        verticalSpace(10),
                        // Specialty shimmer
                        Container(
                          height: 14.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        verticalSpace(16),
                        // Button shimmer
                        Container(
                          height: 32.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
