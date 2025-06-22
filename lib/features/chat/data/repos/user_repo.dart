import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/features/chat/data/model/message_model.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';

class UserRepository {
  final CollectionReference<UserModel> _usersCollection;

  UserRepository()
    : _usersCollection = FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, snapshotOptions) =>
                UserModel.fromFirestore(snapshot, snapshotOptions),
            toFirestore: (user, _) => user.toJson(),
          );

  Stream<List<UserModel>> getUsersStream() {
    try {
      return _usersCollection
          .orderBy('lastActivity', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) => doc.data()).toList();
          })
          .handleError((e) {
            throw FirebaseException(message: "Fetch error: $e", plugin: '');
          });
    } catch (e) {
      return Stream.error(e);
    }
  }
}
