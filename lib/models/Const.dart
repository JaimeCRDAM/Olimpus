import 'package:flutter/material.dart';
import 'package:idk/models/users/User.dart';


class Globals{
  static User? currentUser;

  static void showSnackBar(String text, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}