// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Quest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quest _$QuestFromJson(Map<String, dynamic> json) => Quest(
      json['id'] as int,
      json['type_id'] as int,
      json['description'] as String,
    );

Map<String, dynamic> _$QuestToJson(Quest instance) => <String, dynamic>{
      'id': instance.id,
      'destiny': instance.destiny,
      'chance': instance.chance,
      'virtue': instance.virtue,
      'key_words': instance.keyWords,
      'type_id': instance.typeId+1,
      'description': instance.description
    };
