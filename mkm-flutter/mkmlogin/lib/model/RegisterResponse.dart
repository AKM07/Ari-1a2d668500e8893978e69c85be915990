import 'package:json_annotation/json_annotation.dart';

part 'RegisterResponse.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "status_code")
  int statusCode;
  String message;

  RegisterResponse({this.statusCode, this.message});

  static RegisterResponse fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
