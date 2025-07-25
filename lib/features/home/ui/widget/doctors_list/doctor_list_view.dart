import 'package:doc_app/features/home/data/model/specializations_response_model.dart';
import 'package:doc_app/features/home/ui/widget/doctors_list/doctor_list_view_item.dart';
import 'package:flutter/material.dart';

class DoctorsListView extends StatelessWidget {
  final List<Doctors?>? doctorsList;
  const DoctorsListView({super.key, this.doctorsList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: doctorsList?.length,
        itemBuilder: (context, index) {
          final doctor = doctorsList![index];
          return DoctorsListViewItem(doctorsMode: doctor);
        },
      ),
    );
  }
}
