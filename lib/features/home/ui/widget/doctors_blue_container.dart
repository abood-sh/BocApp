import 'package:doc_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class DoctorsBlueContainer extends StatelessWidget {
  const DoctorsBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 197.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 167.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.r)),
              image: const DecorationImage(
                image: AssetImage('assets/images/home_blue_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Book and\nschedule with\n nearest doctor''',
                  style: TextStyles.font18WhiteMedium,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: Text(
                      'Find a doctor',
                      style: TextStyles.font12BlueRegular,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.w,
            top: 0,
            child: Image.asset(
              'assets/images/doctor_home_container_blue.png',
              height: 197.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
