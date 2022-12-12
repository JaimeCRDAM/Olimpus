import 'package:flutter/material.dart';
import 'package:idk/models/users/User.dart';

import '../services/UserServiceImpl.dart';


class Globals{
  static User? currentUser;
  //static var server = 'http://192.168.209.22:9004/olimpus/'; //Clase
  static var server = 'http://192.168.1.133:9004/olimpus/'; //Casa
  static var storage = 'http://192.168.1.133:9004/storage/'; //Casa
  static var log = "Jaime@email.com";
  static var pass = "p";
  static var userServiceImpl = UserServiceImpl();
  static var questNames = ["Free answer", "Election", "Casual quest", "Valuation"];
  static var virtues = ["Wisdom", "Nobility", "Virtue", "Wickedness", "Audacity"];

  static void showSnackBar(String text, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ));
  }
}