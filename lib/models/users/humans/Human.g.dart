// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Human.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Human _$HumanFromJson(Map<String, dynamic> json) {
  Map<String, dynamic> user = json['user'];
  Map<String, dynamic> auth = json['authorisation'];
  return Human.authHuman(
      Human(
          user['name'] as String,
          user['email'] as String,
          null
      ), auth['token'] as String, auth['type'] as String, user["avatar"] as String);
}

Human _$HumanFromJsonToList(Map<String, dynamic> json) {
  return Human.toList(
      Human(
          json['name'] as String,
          json['email'] as String,
          null
      ), json["avatar"] as String, json["id"] as int);
}

Map<String, dynamic> _$HumanToJsonRegister(Human instance) => <String, dynamic>{
  'name': instance.name,
  'password': instance.password,
  'email': instance.email,
};
Map<String, dynamic> _$HumanToJsonQuest(Human instance) => <String, dynamic>{
  "id": instance.id,
};

Map<String, dynamic> _$HumanToJsonLogin(Human instance) => <String, dynamic>{
  'password': instance.password,
  'email': instance.email,
};

Map<String, dynamic> _$HumanToJsonAuth(Human instance) => <String, dynamic>{
  'type': instance.type,
  'jwt': instance.jwt
};
