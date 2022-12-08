import 'package:json_annotation/json_annotation.dart';

part 'Human.g.dart';

@JsonSerializable()
class Human {
  late String name;
  String? password;
  late String email;
  late String avatar;
  late String jwt;

  Human(this.name, this.email, this.password);
  Human.fromHuman(Human human, this.jwt) {
    name = human.name;
    email = human.email;
  }

  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);

  Map<String, dynamic> toJson() => _$HumanToJson(this);
  Map<String, dynamic> toJsonAuth() => _$HumanToJson(this);
}