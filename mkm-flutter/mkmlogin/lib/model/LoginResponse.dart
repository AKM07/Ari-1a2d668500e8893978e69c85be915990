import 'package:json_annotation/json_annotation.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "status_code")
  int statusCode;
  String message;
  String username;
  @JsonKey(name: "login_time")
  String loginTime;
  @JsonKey(name: "login_state")
  String loginState;

  LoginResponse(
      {this.statusCode,
      this.message,
      this.username,
      this.loginTime,
      this.loginState});

  static LoginResponse fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
