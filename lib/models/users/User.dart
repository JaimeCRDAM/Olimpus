import '../Quest.dart';
import 'humans/Human.dart';

class User {
  late String? name;
  late String? email;
  late String jwt;
  late String type;
  late String avatar;


  Map<String, dynamic>? toJsonAuth(){
    return null;
  }
  Map<String, dynamic>? toJsonLogin(){
    return null;
  }
}