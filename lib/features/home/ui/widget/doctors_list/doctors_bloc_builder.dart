import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/home/logic/home_state.dart';
import 'package:doc_app/features/home/ui/widget/doctors_list/doctor_list_view.dart';
import 'package:doc_app/features/home/ui/widget/speciality_list/doctor_specialty_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsBlocBuilder extends StatelessWidget {
  const DoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is DoctorsSuccess || current is DoctorsError,
      builder: (context, state) {
        return state.maybeWhen(
          // specializationsLoading: () {
          //   return setupLoading();
          // },
          doctorsSuccess: (specializationsResponseModel) {
            var specializationsList = specializationsResponseModel;
            return setupSuccess(specializationsList);
          },
          doctorsError: (errorHandler) {
            return setupError();
          },
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget setupLoading() {
    return const SizedBox(
      height: 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget setupSuccess(specializationsList) {
    return Expanded(
      child: Column(
        children: [DoctorsListView(doctorsList: specializationsList)],
      ),
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
