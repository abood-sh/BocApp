import 'package:json_annotation/json_annotation.dart';
part 'login_req_body.g.dart';

@JsonSerializable()
class LoginReqBody {
  final String email;
  final String password;

  LoginReqBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginReqBodyToJson(this);

  factory LoginReqBody.fromJson(Map<String, dynamic> json) =>
      _$LoginReqBodyFromJson(json);
}
