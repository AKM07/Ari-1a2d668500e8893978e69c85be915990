// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
