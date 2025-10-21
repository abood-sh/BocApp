import 'package:doc_app/core/firebase/firebase_db_handler.dart';
import 'package:doc_app/core/firebase/firebase_error_handler.dart'
    show FirebaseErrorHandler;
import 'package:doc_app/core/helpers/snack_bar_helper.dart';
import 'package:doc_app/features/sign_up/data/model/signup_req_body.dart';
import 'package:doc_app/core/networking/api_result.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_service.dart';

import '../model/signup_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupRepo {
  final ApiService _apiService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignupRepo(this._apiService);
  Future<ApiResult<SignupResponse>> signup(
    SignupRequestBody signupRequestBody,
  ) async {
    try {
      final response = await _apiService.register(signupRequestBody);
      await _createFirebaseUser(signupRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<void> _createFirebaseUser(SignupRequestBody signupRequestBody) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: signupRequestBody.email,
            password: signupRequestBody.password,
          );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': signupRequestBody.name,
        'email': signupRequestBody.email,
        'phone': signupRequestBody.phone,
        'gender': signupRequestBody.gender,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      throw error;
    }
  }
}
