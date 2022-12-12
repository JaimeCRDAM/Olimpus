

import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:idk/models/Quest.dart';
import 'package:idk/models/users/gods/God.dart';
import 'package:idk/models/users/humans/Human.dart';
import 'package:idk/services/UserServiceImpl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../models/Const.dart';

class BornToDiePage extends StatefulWidget {
  const BornToDiePage({Key? key}) : super(key: key);

  @override
  State<BornToDiePage> createState() => _BornToDiePageState();
}

class _BornToDiePageState extends State<BornToDiePage> {

  final waysToMassacre = ["One at a time", "All at once", "I don't care"];
  late final TextEditingController _virtueOrKeyWords;
  late final UserServiceImpl _userServiceImpl;
  late final TextEditingController _amount;
  String _dropdownMassacre = "One at a time";
  Human _dropdownValueHuman = (Globals.currentUser as God).HadesHumans![0];


  @override
  void initState() {
    _virtueOrKeyWords = TextEditingController();
    _amount = TextEditingController();
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
                    const Text("How do you want to massacre them?"),
                    DropdownButton(
                        items: waysToMassacre.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _dropdownMassacre,
                        onChanged: (String? value){
                          setState((){
                            _dropdownMassacre = value!;
                          });
                        }
                    )
                  ],
                ),
                if(_dropdownMassacre == "One at a time")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Who do you want to massacre?"),
                      DropdownButton(
                          items: (Globals.currentUser as God).HadesHumans!.map((value) {
                            return DropdownMenuItem<Human>(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                          value: _dropdownValueHuman,
                          onChanged: (Human? value){
                            setState((){
                              _dropdownValueHuman = value!;
                            });
                          }
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var humans = (Globals.currentUser as God).HadesHumans;
                        List<Human> humansToKill = [];
                        int random = Random().nextInt(humans!.length);

                        if(_dropdownMassacre == "One at a time"){
                          humansToKill.add(_dropdownValueHuman);
                        }
                        if(_dropdownMassacre == "I don't care"){
                          humans.shuffle();
                          humansToKill = humans.sublist(0, random);
                        }
                        _userServiceImpl.massacreHumans(humansToKill).then((value) {
                          if(value){
                            if(_dropdownMassacre == "One at a time"){
                                humans.remove(_dropdownValueHuman);
                            }
                            if(_dropdownMassacre == "I don't care"){
                                humans.removeRange(0, random);
                            }
                            Globals.showSnackBar("All went well", context);
                          } else{
                            Globals.showSnackBar("Error massacrating humans", context);
                          }
                        });
                      },
                      child: const Text("Massacre them"),
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

  List<DropdownMenuItem<Human>> dropDownItemsHumans(List<Human>? listToParse){
    var humanList = <DropdownMenuItem<Human>>[];
    for (var value in listToParse!) {
      humanList.add(
          DropdownMenuItem(
              value: value,
              child: Text("Nombre: ${value.name}")//${value.}
          )
      );
    }
    return humanList;
  }
}