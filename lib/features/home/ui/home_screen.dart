import 'package:doc/core/helpers/spacing.dart';
import 'package:doc/features/home/ui/widget/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/doctor_listview.dart';
import 'widget/doctor_speciality_see_all.dart';
import 'widget/doctor_specialty_listview.dart';
import 'widget/doctors_blue_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        // color: Colors.yellow.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeTopBar(),
            const DoctorsBlueContainer(),
            verticalSpace(24),
            const DoctorSpecialtySeeAll(),
            verticalSpace(16),
            const DoctorSpecialtyListView(),
            verticalSpace(8),
            const DoctorListView()
          ],
        ),
      )),
    );
  }
}
