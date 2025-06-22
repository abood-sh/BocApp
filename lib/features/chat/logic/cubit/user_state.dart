import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';

part 'user_state.freezed.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial() = _Initial;
  const factory UsersState.loading() = Loading;
  const factory UsersState.success(List<UserModel> users) = Success;
  const factory UsersState.error({required String error}) = Error;
}
