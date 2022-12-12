import 'package:flutter/material.dart';
import 'package:idk/models/users/gods/God.dart';
import 'package:idk/models/users/humans/Human.dart';

import '../../../models/Const.dart';

class ContemplateTheDeadPage extends StatefulWidget {
  const ContemplateTheDeadPage({Key? key}) : super(key: key);

  @override
  State<ContemplateTheDeadPage> createState() => _ContemplateTheDeadPageState();
}

class _ContemplateTheDeadPageState extends State<ContemplateTheDeadPage> {

  Human _dropdownValueHuman = (Globals.currentUser as God).deadHumans![0];

  @override
  void initState() {
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
                    const Text("Dead humans: "),
                    DropdownButton(
                        items: (Globals.currentUser as God).deadHumans!.map((value) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}