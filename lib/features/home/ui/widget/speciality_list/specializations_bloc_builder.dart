import 'package:doc_app/features/home/logic/home_cubit.dart';
import 'package:doc_app/features/home/logic/home_state.dart';
import 'package:doc_app/features/home/ui/widget/doctors_list/doctors_shimmer_loading.dart';
import 'package:doc_app/features/home/ui/widget/speciality_list/doctor_specialty_listview.dart';
import 'package:doc_app/features/home/ui/widget/speciality_list/speciality_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/spacing.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is SpecializationsLoading ||
          current is SpecializationsSuccess ||
          current is SpecializationsError,
      builder: (context, state) {
        return state.maybeWhen(
          specializationsLoading: () {
            return setupLoading();
          },
          specializationsSuccess: (specializationsResponseModel) {
            var specializationsList = specializationsResponseModel;
            return setupSuccess(specializationsList);
          },
          specializationsError: (errorHandler) {
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
    return Expanded(
      child: Column(
        children: [
          SpecialityShimmerLoading(),
          verticalSpace(10),
          DoctorsShimmerLoading(),
        ],
      ),
    );
  }

  Widget setupSuccess(specializationsList) {
    return Column(
      children: [
        DoctorSpecialtyListView(
          specializationDataList: specializationsList ?? [],
        ),
      ],
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
