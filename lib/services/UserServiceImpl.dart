import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idk/models/users/gods/God.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';

import 'UserService.dart';

class UserServiceImpl implements UserService {
  var server = 'http://192.168.1.133:9004/olimpus/';

  @override
  Future<User?> loginUser(User user) async {
    var loginRoute = user.email != null ? "humans/login": "gods/login";
    var response = await http.post(
        Uri.parse('$server$loginRoute'),
        body: user.toJsonLogin()
    );
    if(response.statusCode != 200) return null;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    return user.email != null ? Human.fromJson(bodyAsJson) : God.fromJson(bodyAsJson);
  }

  @override
  Future<User?> registerHuman(Human human) async {
    var response = await http.post(
        Uri.parse('${server}humans/register'),
        body: human.toJsonRegister()
    );
    if(response.statusCode != 200) return null;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    return Human.fromJson(bodyAsJson);
  }
}