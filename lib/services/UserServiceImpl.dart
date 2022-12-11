import 'dart:convert';
import 'dart:io';
import 'package:idk/models/Quest.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:idk/models/users/gods/God.dart';
import '../models/Const.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';

import 'UserService.dart';

class UserServiceImpl implements UserService {

  @override
  Future<void> loginUser(User user) async {
    var loginRoute = user.email != null ? "humans/login": "gods/login";
    var response = await http.post(
        Uri.parse('${Globals.server}$loginRoute'),
        body: user.toJsonLogin()
    );
    if(response.statusCode != 200) return null;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    user.email != null ? Human.fromJson(bodyAsJson) : God.fromJson(bodyAsJson);
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

  @override
  Future<bool> createQuest(Quest quest) async {
    var route = "quest";
    var body = json.encode(quest.toJson());
    var response = await http.post(
        Uri.parse('${Globals.server}$route'),
        body: body,
        headers: {
          "content-type": "application/json",
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser?.jwt}",
          "Accept": "application/json",
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    var decoded = json.decode(response.body);
    print(decoded);
    return false;
  }

  @override
  Future<List<Human>?> getAllHumans() async {
    try {
      var route = "gods/humans";
      var response = await http.get(
          Uri.parse('${Globals.server}$route'),
          headers: {
            "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
                ?.jwt}"
          }
      );
      Map<String, dynamic> bodyAsJson = json.decode(response.body);
      List<Human> temp = (bodyAsJson["humans"] as List)
          .map((human) => Human.fromJson(human))
          .toList();
      return temp;
    } catch(e){
      e.hashCode;
    }
    return null;
  }

  @override
  Future<List<Quest>?> getAllQuests() async {
    var ak = "${Globals.currentUser?.type} ${Globals.currentUser
        ?.jwt}";
    try {
      var route = "gods/quests";
      var response = await http.get(
          Uri.parse('${Globals.server}$route'   ),
          headers: {
            "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
                ?.jwt}",
            "Accept": "application/json",
          }
      );
      Map<String, dynamic> bodyAsJson = json.decode(response.body);
      var decoded = json.decode(response.body);
      print(decoded);
      List<Quest> temp = (bodyAsJson["quests"] as List)
          .map((quest) => Quest.fromJson(quest))
          .toList();
      return temp;
    } catch(e){

      e.hashCode;
    }
    return null;
  }

}