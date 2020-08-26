// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    statusCode: json['status_code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
    };
