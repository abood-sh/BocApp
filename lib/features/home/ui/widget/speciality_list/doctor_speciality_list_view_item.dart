import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/features/home/data/model/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theming/styles.dart';

class DoctorSpecialityListViewItem extends StatelessWidget {
  final SpecializationsData? specializationsData;
  final int itemIndex;
  final int selectedIndex;
  const DoctorSpecialityListViewItem({
    super.key,
    this.specializationsData,
    required this.itemIndex,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: itemIndex == 0 ? 0 : 24.w),
      child: Column(
        children: [
          itemIndex == selectedIndex
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [ColorsManager.darkBlue, ColorsManager.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.all(3.5), // space for border
                  child: CircleAvatar(
                    radius: 28.r, // slightly larger
                    backgroundColor: ColorsManager.lightBlue,
                    child: SvgPicture.asset(
                      'assets/svgs/general_speciality.svg',
                      height: 42.h,
                      width: 42.w,
                    ),
                  ),
                )
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: ColorsManager.darkBlue
              //     ),
              //     shape: BoxShape.circle,
              //   ),
              //   child: CircleAvatar(
              //   radius: 28.r,
              //   backgroundColor: ColorsManager.lightBlue,
              //   child: SvgPicture.asset(
              //     'assets/svgs/general_speciality.svg',
              //     height: 42.h,
              //     width:  42.w,
              //   ),
              // ),
              // )
              : CircleAvatar(
                  radius: 28.r,
                  backgroundColor: ColorsManager.lightBlue,
                  child: SvgPicture.asset(
                    'assets/svgs/general_speciality.svg',
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
          verticalSpace(5),
          Text(
            specializationsData?.name ?? "Specializations",
            style: itemIndex == selectedIndex
                ? TextStyles.font14DarkBlueMedium(context)
                : TextStyles.font12DarkBlueRegular(context),
          ),
        ],
      ),
    );
  }
}
