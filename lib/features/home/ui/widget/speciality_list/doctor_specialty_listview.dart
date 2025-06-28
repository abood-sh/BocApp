import 'package:doc_app/features/home/data/model/specializations_response_model.dart';
import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/home/ui/widget/speciality_list/doctor_speciality_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialtyListView extends StatefulWidget {
  final List<SpecializationsData?> specializationDataList;
  const DoctorSpecialtyListView({
    super.key,
    required this.specializationDataList,
  });

  @override
  State<DoctorSpecialtyListView> createState() =>
      _DoctorSpecialtyListViewState();
}

class _DoctorSpecialtyListViewState extends State<DoctorSpecialtyListView> {
  var selectedSpecializationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        itemCount: widget.specializationDataList.length,
        scrollDirection: Axis.horizontal,
        //physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSpecializationIndex = index;
              });
              context.read<HomeCubit>().getDoctorList(
                specializationId: widget.specializationDataList[index]?.id,
              );
            },
            child: DoctorSpecialityListViewItem(
              specializationsData: widget.specializationDataList[index],
              itemIndex: index,
              selectedIndex: selectedSpecializationIndex,
            ),
          );
        },
      ),
    );
  }
}
