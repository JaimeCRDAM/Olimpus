// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'God.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

God _$GodFromJson(Map<String, dynamic> json) {
  Map<String, dynamic> user = json['user'];
  Map<String, dynamic> auth = json['authorisation'];
  return God.authGod(
      God(
          user['god_name'] as String,
          null
      ), auth['token'] as String, auth['type'] as String, user["avatar"]);
}

Map<String, dynamic> _$GodToJsonLogin(God instance) => <String, dynamic>{
  'password': instance.password,
  'god_name': instance.name,
};

Map<String, dynamic> _$GodToJsonAuth(God instance) => <String, dynamic>{
  'type': instance.type,
  'jwt': instance.jwt
};
