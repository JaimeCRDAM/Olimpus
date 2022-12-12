

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:idk/models/Quest.dart';
import 'package:idk/models/users/gods/God.dart';
import 'package:idk/models/users/humans/Human.dart';
import 'package:idk/services/UserServiceImpl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../models/Const.dart';

class HumanCreatorPage extends StatefulWidget {
  const HumanCreatorPage({Key? key}) : super(key: key);

  @override
  State<HumanCreatorPage> createState() => _HumanCreatorPageState();
}

class _HumanCreatorPageState extends State<HumanCreatorPage> {

  final nameList = ["Marconaukas", "Jaimeniakis", "Josepoulus", "Alonsinidis", "Adrianathes", "Mariakas", "Alfredokis", "Jorgepulos", "Antonionides", "Cristianakis", "Helenoulas", "Oscarinis", "Aironopoulakis", "Davidathes", "Other"];
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final UserServiceImpl _userServiceImpl;
  late String _dropdownValue;


  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _dropdownValue = nameList[0];
    _userServiceImpl = UserServiceImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${Globals.currentUser?.name}"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Name"),
                    DropdownButton(
                        items: nameList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _dropdownValue,
                        onChanged: (String? value){
                          setState((){
                            _dropdownValue = value!;
                          });
                        }
                    )
                  ],
                ),
                if(_dropdownValue == "Other")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Name"),
                      IntrinsicWidth(
                        child: TextField(
                          controller: _name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                          ),
                        ),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Email"),
                    IntrinsicWidth(
                      child: TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Password"),
                    IntrinsicWidth(
                      child: TextField(
                        controller: _password,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final human = Human(
                            _dropdownValue == "Other" ? _name.text : _dropdownValue,
                            _email.text,
                            _password.text,
                        );
                        _userServiceImpl.registerHumanByGod(human).then((value) {
                          if(value){
                            Globals.showSnackBar("Human created successfully", context);
                          } else{
                            Globals.showSnackBar("Error creating human", context);
                          }
                        });
                      },
                      child: const Text("Create Human"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> dropDownItems(List<String>? listToParse){
    var list = <DropdownMenuItem<String>>[];
    for (var value in listToParse!) {
      list.add(
          DropdownMenuItem(
              value: value,
              child: Text("Name: $value")
          )
      );
    }
    return list;
  }

}