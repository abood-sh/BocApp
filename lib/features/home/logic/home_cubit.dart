import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/networking/api_error_handler.dart';
import 'package:doc_app/core/networking/api_error_model.dart';
import 'package:doc_app/features/home/data/model/specializations_response_model.dart';
import 'package:doc_app/features/home/data/repos/home_repo.dart';
import 'package:doc_app/features/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  List<SpecializationsData?>? specializationsList = [];

  void getSpecialization() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecialization();
    response.when(
      success: (specializationsResponseModel) {
        specializationsList =
            specializationsResponseModel!.specializationDataList ?? [];
        getDoctorList(specializationId: specializationsList?.first?.id);
        emit(HomeState.specializationsSuccess(specializationsList));
      },
      failure: (apiErrorModel) {
        emit(HomeState.specializationsError(apiErrorModel));
      },
    );
  }

  void getDoctorList({required int? specializationId}) async {
    List<Doctors?>? doctorsList = filterSpecializationById(specializationId!);
    if (!doctorsList.isNullOrEmpty()) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      emit(HomeState.doctorsError());
    }
  }

  /// Filters the list of specializations to find the doctors for a specific specialization by its ID.
  /// Returns a list of doctors if found, otherwise returns an empty list.
  filterSpecializationById(int specializationId) {
    return specializationsList
            ?.firstWhere(
              (specialization) => specialization?.id == specializationId,
              orElse: () => null,
            )
            ?.doctorsList ??
        [];
  }
}
