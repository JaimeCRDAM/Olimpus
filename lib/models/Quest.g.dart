// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Quest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quest _$QuestFromJson(Map<String, dynamic> json) => Quest(
      json['destiny'] as int,
      (json['chance'] as num).toDouble(),
      json['virtue'] as String?,
      json['key_words'] as String?,
      json['type_id'] as int,
    );

Map<String, dynamic> _$QuestToJson(Quest instance) => <String, dynamic>{
      'destiny': instance.destiny,
      'chance': instance.chance,
      'virtue': instance.virtue,
      'key_words': instance.keyWords,
      'type_id': instance.typeId+1,
    };
