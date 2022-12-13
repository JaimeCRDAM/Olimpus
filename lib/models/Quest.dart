import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Quest.g.dart';

@JsonSerializable()
class Quest{
  int? id;
  int? destiny;
  double? chance;
  int? virtue;
  String? keyWords;
  int typeId;
  String description;

  Quest(this.id, this.typeId, this.description);
  Quest.authQuest(this.id, this.destiny, this.chance, this.virtue, this.keyWords, this.typeId, this.description);

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestToJson(this);

}