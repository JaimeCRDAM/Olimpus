

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:idk/models/Quest.dart';
import 'package:idk/services/UserServiceImpl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../models/Const.dart';

class QuestMakerPage extends StatefulWidget {
  const QuestMakerPage({Key? key}) : super(key: key);

  @override
  State<QuestMakerPage> createState() => _QuestMakerPageState();
}

class _QuestMakerPageState extends State<QuestMakerPage> {

  late final TextEditingController _destiny;
  late final TextEditingController _chance;
  late final TextEditingController _virtueOrKeyWords;
  late final TextEditingController _description;
  late final UserServiceImpl _userServiceImpl;
  int _dropdownValue = 0;
  int _dropdownValueVirtues = 0;
  late File imgFile;
  late int questId;

  @override
  void initState() {
    _destiny = TextEditingController();
    _destiny.text = "0";
    _description = TextEditingController();
    _chance = TextEditingController();
    _chance.text = "0";
    _virtueOrKeyWords = TextEditingController();
    _virtueOrKeyWords.text = "";
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
                    const Text("Quest type"),
                    DropdownButton(
                        items: dropDownItems(Globals.questNames),
                        value: _dropdownValue,
                        onChanged: (int? value){
                          setState((){
                            _dropdownValue = value!;
                            _virtueOrKeyWords.text = "";
                          });
                        }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Destiny"),
                    numericValueWithCheckAndWidth<int>("Destiny", _destiny, "0")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Chance of success"),
                    numericValueWithCheckAndWidth<double>("Chance", _chance, "0")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Description"),
                    IntrinsicWidth(
                        child: TextField(
                        controller: _description,
                        decoration:  const InputDecoration(
                            hintText: "Description "
                        ),
                        textAlign: TextAlign.center,
                      )
                    )
                  ],
                ),
                virtueOrKeyWords("Words separated by spaces", _virtueOrKeyWords),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed:(){
                          var quest = Quest.authQuest(
                              null,
                              int.parse(_destiny.text),
                              double.parse(_chance.text),
                              _dropdownValue == 0 ? null : _dropdownValueVirtues+1,
                              _virtueOrKeyWords.text,
                              _dropdownValue,
                              _description.text
                          );
                           _userServiceImpl.createQuest(quest).then((value){
                             if(!value){
                               Globals.showSnackBar("Quest not created", context);
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

  List<DropdownMenuItem<int>> dropDownItems(List<String> listToParse){
    var list = <DropdownMenuItem<int>>[];
    var index = 0;
    for (var value in listToParse) {
      list.add(
        DropdownMenuItem(
          value: index,
          child: Text(value))
      );
      index++;
    }
    return list;
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

  Row virtueOrKeyWords(String field, TextEditingController controller){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _dropdownValue == 0 ?  const Text("Key Words") : const Text("Virtue"),
        _dropdownValue == 0 ? IntrinsicWidth(
            child: TextField(
              controller: controller,
              decoration:  InputDecoration(
                  hintText: field
              ),
              textAlign: TextAlign.center,
            )
        ):  DropdownButton(
            items: dropDownItems(Globals.virtues),
            value: _dropdownValueVirtues,
            onChanged: (int? value){
              setState((){
                _dropdownValueVirtues = value!;
              });
            }
        )
      ],
    );
  }

}