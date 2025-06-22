// import 'package:doc_app/features/chat/data/repos/firebase_repo.dart';
// import 'package:doc_app/features/chat/logic/cubit/user_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/core/networking/api_result.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';
import 'package:doc_app/features/chat/data/repos/user_repo.dart';
import 'package:doc_app/features/chat/logic/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UsersState> {
  final UserRepository _repository;
  StreamSubscription? _usersSubscription;
  TextEditingController? inputTextController;

  UserCubit(this._repository) : super(const UsersState.initial());

  Future<void> getUsersStream() async {
    _usersSubscription?.cancel();
    emit(const UsersState.loading());
    _usersSubscription = _repository.getUsersStream().listen(
      (users) {
        emit(UsersState.success(users));
      },
      onError: (error) {
        emit(UsersState.error(error: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
