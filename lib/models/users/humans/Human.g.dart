// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Human.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Human _$HumanFromJson(Map<String, dynamic> json) => Human(
      json['name'] as String?,
      json['email'] as String?,
      json['password'] as String?,
    )
      ..avatar = json['avatar'] as String
      ..jwt = json['jwt'] as String
      ..type = json['type'] as String;

Map<String, dynamic> _$HumanToJson(Human instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'avatar': instance.avatar,
      'jwt': instance.jwt,
      'type': instance.type,
    };
