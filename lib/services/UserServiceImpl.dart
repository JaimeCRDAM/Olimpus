import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:idk/models/users/gods/God.dart';
import '../models/Const.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';

import 'UserService.dart';

class UserServiceImpl implements UserService {

  @override
  Future<User?> loginUser(User user) async {
    var loginRoute = user.email != null ? "humans/login": "gods/login";
    var response = await http.post(
        Uri.parse('${Globals.server}$loginRoute'),
        body: user.toJsonLogin()
    );
    if(response.statusCode != 200) return null;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    return user.email != null ? Human.fromJson(bodyAsJson) : God.fromJson(bodyAsJson);
  }

  @override
  Future<User?> registerHuman(Human human) async {
    var response = await http.post(
        Uri.parse('${Globals.server}humans/register'),
        body: human.toJsonRegister()
    );
    if(response.statusCode != 200) return null;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    return Human.fromJson(bodyAsJson);
  }

  @override
  Future<bool?> updatePassword(User user, String password) async {
    var loginRoute = user.email != null ? "humans/updatepassword": "gods/updatepassword";
    var response = await http.post(
        Uri.parse('${Globals.server}$loginRoute'),
        body: {
          "password": password,
        },
        headers: {
          "Authorization": "${user.type} ${user.jwt}"
        }
    );
    if(response.statusCode != 200) return null;
    return true;

  }

  @override
  Future<bool> updateAvatar(User user, File image) async {
    var loginRoute = user.email != null ? "humans/avatar": "gods/avatar";
    String base64Image;
    String fileExtension = extension(image.path);
    base64Image = base64Encode(await image.readAsBytes());

    var response = await http.post(
        Uri.parse('${Globals.server}$loginRoute'),
        body: {
          "imageType": fileExtension,
          "base64String": base64Image
        },
        headers: {
          "Authorization": "${user.type} ${user.jwt}"
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }

  @override
  Future<bool> logOut(User user) async {
    var route = user.email != null ? "humans/logout": "gods/logout";
    var response = await http.post(
        Uri.parse('${Globals.server}$route'),
        headers: {
          "Authorization": "${user.type} ${user.jwt}"
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;

  }
}