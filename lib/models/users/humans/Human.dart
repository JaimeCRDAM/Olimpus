import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../Const.dart';

part 'Human.g.dart';

@JsonSerializable()
class Human implements User{
  @override
  late String? name;
  String? password;
  @override
  late String? email;
  @override
  late String avatar;
  @override
  late String jwt;
  @override
  late String type;

  late int id;

  late int fate;

  late int wisdom;

  late int nobility;

  late int virtue;

  late int wickedness;

  late int audacity;

  late int alive;

  Human(this.name, this.email, this.password);
  Human.authHuman(Human human, this.jwt, this.type, this.avatar, this.fate, this.wisdom, this.nobility, this.virtue, this.wickedness, this.audacity, this.alive){
    name = human.name;
    email = human.email;
    Globals.currentUser = this;
  }

  Human.toList(Human human,this.avatar, this.id) {
    name = human.name;
    email = human.email;
  }


  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);
  factory Human.fromJsonToList(Map<String, dynamic> json) => _$HumanFromJsonToList(json);

  Map<String, dynamic> toJsonRegister() => _$HumanToJsonRegister(this);
  Map<String, dynamic> toJsonQuest() => _$HumanToJsonQuest(this);
  @override
  Map<String, dynamic> toJsonAuth() => _$HumanToJsonAuth(this);
  @override
  Map<String, dynamic> toJsonLogin() => _$HumanToJsonLogin(this);
}