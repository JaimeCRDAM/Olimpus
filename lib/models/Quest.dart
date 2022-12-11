import 'package:idk/models/users/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Quest.g.dart';

@JsonSerializable()
class Quest{
  int destiny;
  double chance;
  String? virtue;
  String? keyWords;
  int typeId;

  Quest(this.name, this.password);


}