import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

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

  God(this.name, this.password);
  God.authGod(God god, this.jwt, this.type, this.avatar) {
    name = god.name;
  }

  factory God.fromJson(Map<String, dynamic> json) => _$GodFromJson(json);

  @override
  Map<String, dynamic> toJsonAuth() => _$GodToJsonAuth(this);
  @override
  Map<String, dynamic> toJsonLogin() => _$GodToJsonLogin(this);


}