import 'package:doc/core/networking/api_error_handler.dart';
import 'package:doc/features/home/data/model/specializations_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  // Specializations
  const factory HomeState.specializationsLoading() = SpecializationsLoading;
  const factory HomeState.specializationsSuccess(
          SpecializationsResponseModel specializationsResponseModel) =
      SpecializationsSuccess;
  const factory HomeState.specializationsError(ErrorHandler errorHandler) =
      SpecializationsError;

  // Doctors
  // const factory HomeState.doctorsSuccess(List<Doctors?>? doctorsList) =
  //     DoctorsSuccess;
  // const factory HomeState.doctorsError(ErrorHandler errorHandler) =
  //     DoctorsError;
}
