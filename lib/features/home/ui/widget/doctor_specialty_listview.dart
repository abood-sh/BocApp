import 'package:doc/features/home/data/model/specializations_response_model.dart';
import 'package:doc/features/home/ui/widget/doctor_speciality_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialtyListView extends StatelessWidget {
  final List<SpecializationsData?> specializationDataList;
  const DoctorSpecialtyListView(
      {super.key, required this.specializationDataList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        itemCount: specializationDataList.length,
        scrollDirection: Axis.horizontal,
        //physics: const BouncingScrollPhysics(),
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          return DoctorSpecialityListViewItem(
              specializationsData: specializationDataList[index],
              itemIndex: index);
        },
      ),
    );
  }
}
