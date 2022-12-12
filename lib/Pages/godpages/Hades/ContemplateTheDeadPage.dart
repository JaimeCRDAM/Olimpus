

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:idk/models/Quest.dart';
import 'package:idk/models/users/gods/God.dart';
import 'package:idk/models/users/humans/Human.dart';
import 'package:idk/services/UserServiceImpl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../models/Const.dart';

class ContemplateTheDeadPage extends StatefulWidget {
  const ContemplateTheDeadPage({Key? key}) : super(key: key);

  @override
  State<ContemplateTheDeadPage> createState() => _ContemplateTheDeadPageState();
}

class _ContemplateTheDeadPageState extends State<ContemplateTheDeadPage> {

  late final TextEditingController _destiny;
  late final TextEditingController _chance;
  late final TextEditingController _virtueOrKeyWords;
  late final UserServiceImpl _userServiceImpl;
  late final TextEditingController _amount;
  Human _dropdownValueHuman = (Globals.currentUser as God).humans![0];
  Quest _dropdownValueQuest = (Globals.currentUser as God).quests![0];
  int _dropdownValueQuestion = 0;
  late File imgFile;
  late int questId;


  @override
  void initState() {
    _destiny = TextEditingController();
    _destiny.text = "0";
    _chance = TextEditingController();
    _chance.text = "0";
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
                    const Text("Quest to assign"),
                    DropdownButton(
                        items: dropDownItems((Globals.currentUser as God).quests),
                        value: _dropdownValueQuest,
                        onChanged: (Quest? value){
                          setState((){
                            _dropdownValueQuest = value!;
                          });
                        }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Human"),
                    DropdownButton(
                        items: [0,1].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(["One Human", "Random Humans"][value]),
                          );
                        }).toList(),
                        value: _dropdownValueQuestion,
                        onChanged: (int? value){
                          setState((){
                            _dropdownValueQuestion = value!;
                          });
                        }
                    )
                  ],
                ),
                if(_dropdownValueQuestion == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Human"),
                      DropdownButton(
                          items: dropDownItemsHumans((Globals.currentUser as God).humans),
                          value: _dropdownValueHuman,
                          onChanged: (Human? value){
                            setState((){
                              _dropdownValueHuman = value!;
                            });
                          }
                      )
                    ],
                  ),
                if(_dropdownValueQuestion == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Amount of humans"),
                      IntrinsicWidth(
                          child: TextField(
                            controller: _amount,
                            decoration:  const InputDecoration(
                                hintText: "Amount"
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                          )
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed:(){
                          _userServiceImpl.assignQuest(
                              _dropdownValueQuest,
                              _dropdownValueHuman,
                              _dropdownValueQuestion,
                              _amount.text == "" ? 0 : int.parse(_amount.text)
                          ).then((value){
                            if(value){
                              Globals.showSnackBar("Quest assigned", context);
                            } else {
                              Globals.showSnackBar("Error assigning quest", context);
                            }
                          });
                        },
                        child: const Text("Save")
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

  List<DropdownMenuItem<Quest>> dropDownItems(List<Quest>? listToParse){
    var list = <DropdownMenuItem<Quest>>[];
    for (var value in listToParse!) {
      list.add(
          DropdownMenuItem(
              value: value,
              child: Text("Quest: ${Globals.questNames[value.typeId-1]}\n"
                  "${value.description}")//${value.}
          )
      );
    }
    return list;
  }//Deberian ser genericos, pero no se como usarlos correctamente

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

  IntrinsicWidth numericValueWithCheckAndWidth<T>(String field, TextEditingController controller, String reset){
    return IntrinsicWidth(
        child: TextField(
          controller: controller,
          decoration:  InputDecoration(
              hintText: field
          ),
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(),
          onSubmitted: (String? value){
            try{
              if (T is int){
                int.parse(value!);
              } else{
                double.parse(value!);
              }
            } catch(e){
              Globals.showSnackBar("Please enter a valid number", context);
              setState(() {
                controller.text = reset;
              });
            }
          },
        )
    );
  }
}