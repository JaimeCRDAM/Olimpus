// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Human.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Human _$HumanFromJson(Map<String, dynamic> json) =>
    Human.fromHuman(
        Human(
          json['name'] as String,
          json['email'] as String,
          null
    ), json['jwt']);

Map<String, dynamic> _$HumanToJson(Human instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
    };
