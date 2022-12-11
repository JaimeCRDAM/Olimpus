// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'God.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

God _$GodFromJson(Map<String, dynamic> json) => God(
      json['name'] as String?,
      json['password'] as String?,
    )
      ..avatar = json['avatar'] as String
      ..jwt = json['jwt'] as String
      ..type = json['type'] as String
      ..email = json['email'] as String?;

Map<String, dynamic> _$GodToJson(God instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'avatar': instance.avatar,
      'jwt': instance.jwt,
      'type': instance.type,
      'email': instance.email,
    };
