import 'package:json_annotation/json_annotation.dart';

part 'RegisterRequest.g.dart';

@JsonSerializable()
class RegisterRequest {
  String username;
  String password;

  RegisterRequest({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
