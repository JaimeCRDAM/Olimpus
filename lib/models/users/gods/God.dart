import 'dart:io';

import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../Const.dart';
import '../../Quest.dart';
import '../humans/Human.dart';

part 'God.g.dart';

@JsonSerializable()
class God implements User{
  @override
  String? name;
  String? password;
  @override
  late String avatar;
  @override
  late String jwt;
  @override
  late String type;
  @override
  String? email;
  late List<Human>? humans;
  late List<Quest>? quests;

  God(this.name, this.password);
  God.authGod(God god, this.jwt, this.type, this.avatar){
    name = god.name;
    Globals.currentUser = this;
    Globals.userServiceImpl.getAllHumans().then((value){humans = value;});
    Globals.userServiceImpl.getAllQuests().then((value){
      quests = value;
      return;
    });
  }

  factory God.fromJson(Map<String, dynamic> json) => _$GodFromJson(json);

  @override
  Map<String, dynamic> toJsonAuth() => _$GodToJsonAuth(this);
  @override
  Map<String, dynamic> toJsonLogin() => _$GodToJsonLogin(this);


}