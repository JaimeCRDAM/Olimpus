import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Human.g.dart';

@JsonSerializable()
class Human implements User{
  @override
  late String? name;
  String? password;
  @override
  late String? email;
  late String avatar;
  @override
  late String jwt;
  @override
  late String type;

  Human(this.name, this.email, this.password);
  Human.authHuman(Human human, this.jwt, this.type) {
    name = human.name;
    email = human.email;
  }

  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);

  Map<String, dynamic> toJsonRegister() => _$HumanToJsonRegister(this);
  @override
  Map<String, dynamic> toJsonAuth() => _$HumanToJsonAuth(this);
  @override
  Map<String, dynamic> toJsonLogin() => _$HumanToJsonLogin(this);
}