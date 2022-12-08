import 'package:json_annotation/json_annotation.dart';

part 'Human.g.dart';

@JsonSerializable()
class Human {
  final String name;
  final String password;
  final String email;
  late String avatar;
  late String jwt;

  Human(this.name, this.password, this.email);

  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);

  Map<String, dynamic> toJson() => _$HumanToJson(this);
  Map<String, dynamic> toJsonAuth() => _$HumanToJson(this);
}