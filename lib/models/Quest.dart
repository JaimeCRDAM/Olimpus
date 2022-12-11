import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Quest.g.dart';

@JsonSerializable()
class Quest{
  int destiny;
  double chance;
  int? virtue;
  String? keyWords;
  int typeId;

  Quest(this.destiny, this.chance, this.virtue, this.keyWords, this.typeId);

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestToJson(this);

}