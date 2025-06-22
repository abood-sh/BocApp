import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final DateTime lastActivity;
  final bool isOnline;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.lastActivity,
    required this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Firestore converter
  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return UserModel(
      uid: snapshot.id,
      email: data['email'] as String,
      name: data['name'] as String,
      lastActivity: (data['lastActivity'] as Timestamp).toDate(),
      isOnline: data['isOnline'] as bool,
      profileImageUrl: data['profileImageUrl'] as String,
    );
  }
}
