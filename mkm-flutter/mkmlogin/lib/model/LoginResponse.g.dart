// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    statusCode: json['status_code'] as int,
    message: json['message'] as String,
    username: json['username'] as String,
    loginTime: json['login_time'] as String,
    loginState: json['login_state'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'username': instance.username,
      'login_time': instance.loginTime,
      'login_state': instance.loginState,
    };
