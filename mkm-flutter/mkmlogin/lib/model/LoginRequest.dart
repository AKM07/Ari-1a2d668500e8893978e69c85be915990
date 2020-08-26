import 'package:json_annotation/json_annotation.dart';

part 'LoginRequest.g.dart';

@JsonSerializable()
class LoginRequest {
  String username;
  String password;
  String loginTime;

  LoginRequest({
    this.username,
    this.password,
    this.loginTime,
  });

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
