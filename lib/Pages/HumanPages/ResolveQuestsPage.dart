import 'package:flutter/material.dart';
import 'package:idk/models/Quest.dart';
import 'package:idk/models/users/humans/Human.dart';
import 'package:idk/services/UserServiceImpl.dart';

import '../../models/Const.dart';

class ResolveQuestsPage extends StatefulWidget {
  const ResolveQuestsPage({Key? key}) : super(key: key);

  @override
  State<ResolveQuestsPage> createState() => _ResolveQuestsPageState();
}

class _ResolveQuestsPageState extends State<ResolveQuestsPage> {

  late final TextEditingController _answer;
  late final UserServiceImpl _userServiceImpl;
  Quest _dropdownValueQuest = (Globals.currentUser as Human).quests![0];


  @override
  void initState() {
    _answer = TextEditingController();
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
                    const Text("Quests"),
                    DropdownButton(
                        items: dropDownItems((Globals.currentUser as Human).quests),
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
                    const Text("Description"),
                    Text(_dropdownValueQuest.description),
                  ],
                ),
                if(_dropdownValueQuest.typeId != 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Answer"),
                      IntrinsicWidth(
                          child: TextField(
                            controller: _answer,
                            decoration:  const InputDecoration(
                                hintText: "Answer"
                            ),
                            textAlign: TextAlign.center,
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
                          if(_dropdownValueQuest.typeId == 1){
                            _userServiceImpl.resolveQuest(_dropdownValueQuest.id!, null).then((value){
                              if(value!){
                                Globals.showSnackBar("Quest Resolved", context);
                              }else{
                                Globals.showSnackBar("Quest not resolved", context);
                              }
                            });
                          }else{
                            _userServiceImpl.resolveQuest(_dropdownValueQuest.id!, _answer.text).then((value){
                              if(value!){
                                Globals.showSnackBar("Quest Resolved", context);
                              }else{
                                Globals.showSnackBar("Quest not resolved", context);
                              }
                            });
                          }
                        },
                        child: const Text("Try")
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
              child: Text("Quest: ${Globals.questNames[value.typeId-1]}")
          )
      );
    }
    return list;
  }
}