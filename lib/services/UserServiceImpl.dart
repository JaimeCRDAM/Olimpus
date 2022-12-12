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
  Future<bool> loginUser(User user) async {
    var loginRoute = user.email != null ? "humans/login": "gods/login";
    var response = await http.post(
        Uri.parse('${Globals.server}$loginRoute'),
        body: user.toJsonLogin()
    );
    if(response.statusCode != 200) return false;
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    user.email != null ? Human.fromJson(bodyAsJson) : God.fromJson(bodyAsJson);
    return true;
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
          .map((human) => Human.fromJsonToList(human))
          .toList();
      return temp;
    } catch(e){
      e.hashCode;
    }
    return null;
  }

  @override
  Future<List<Human>?> getAllHumansHades() async {
    try {
      var route = "hades/humans";
      var response = await http.get(
          Uri.parse('${Globals.server}$route'),
          headers: {
            "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
                ?.jwt}"
          }
      );
      Map<String, dynamic> bodyAsJson = json.decode(response.body);
      List<Human> temp = (bodyAsJson["humans"] as List)
          .map((human) => Human.fromJsonToList(human))
          .toList();
      return temp;
    } catch(e){
      e.hashCode;
    }
    return null;
  }

  @override
  Future<List<Quest>?> getAllQuests() async {
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
      List<Quest> temp = (bodyAsJson["quests"] as List)
          .map((quest) => Quest.fromJson(quest))
          .toList();
      return temp;
    } catch(e){
      e.hashCode;
    }
    return null;
  }

  @override
  Future<bool> assignQuest(Quest dropdownValueQuest, Human dropdownValueHuman, int dropdownValueQuestion, int amount) async {
    var quest = dropdownValueQuest.toJson();
    var human = dropdownValueQuestion == 0 ? dropdownValueHuman.toJsonQuest() : (Globals.currentUser as God).humans?.map((human){
      return human.toJsonQuest();
    }).toList();

    if(human is List){
      human.shuffle();
      human = human.sublist(0, amount);
    }
    var jsonBody = json.encode({
      "quest": quest,
      "human": human,
      "multiple": dropdownValueQuestion == 1 ? true : false,
    });
    var route = "gods/quests";
    var response = await http.post(
        Uri.parse('${Globals.server}$route'),
        body: jsonBody,
        headers: {
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
              ?.jwt}",
          "content-type": "application/json",
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }

  @override
  Future<bool> registerHumanByGod(Human human) async {
    var response = await http.post(
        Uri.parse('${Globals.server}gods/human'),
        body: human.toJsonRegister(),
        headers: {
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
              ?.jwt}"
        }
    );
    if(response.statusCode != 200) return false;
    return true;
  }

  @override
  Future<bool> massacreHumans(List<Human> humans) async {
    var jsonBody = json.encode({
      "humans": humans.map((human){return human.toJsonQuest();}).toList(),
    });
    var route = "hades/humans";
    var response = await http.post(
        Uri.parse('${Globals.server}$route'),
        body: jsonBody,
        headers: {
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
              ?.jwt}",
          "content-type": "application/json",
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }

  @override
  Future<List<Human>?> getAllHumansDead() async {
    var route = "hades/watchhumans";
    var response = await http.get(
        Uri.parse('${Globals.server}$route'),
        headers: {
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
              ?.jwt}",
          "content-type": "application/json",
        }
    );
    Map<String, dynamic> bodyAsJson = json.decode(response.body);
    List<Human> temp = (bodyAsJson["humans"] as List)
        .map((human) => Human.fromJsonToList(human))
        .toList();
    return temp;
  }

  @override
  Future<bool> changeDestiny(int destiny) async {
    var jsonBody = json.encode({
      "destiny": destiny,
    });
    var route = "gods/destiny";
    var response = await http.post(
        Uri.parse('${Globals.server}$route'),
        body: jsonBody,
        headers: {
          "Authorization": "${Globals.currentUser?.type} ${Globals.currentUser
              ?.jwt}",
          "content-type": "application/json",
        }
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }
}