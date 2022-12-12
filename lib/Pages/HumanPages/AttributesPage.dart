import 'package:flutter/material.dart';
import 'package:idk/models/users/humans/Human.dart';

import '../../models/Const.dart';


class AttributesPage extends StatefulWidget {
  const AttributesPage({Key? key}) : super(key: key);

  @override
  State<AttributesPage> createState() => _AttributesPageState();
}

class _AttributesPageState extends State<AttributesPage> {


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
                    const Text("fate"),
                    Text(
                      (Globals.currentUser as Human).fate.toString(),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("wisdom"),
                    Text(
                      (Globals.currentUser as Human).wisdom.toString(),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("nobility"),
                    Text(
                      (Globals.currentUser as Human).nobility.toString(),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("virtue"),
                    Text(
                      (Globals.currentUser as Human).virtue.toString(),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("wickedness"),
                    Text(
                      (Globals.currentUser as Human).wickedness.toString(),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("audacity"),
                    Text(
                      (Globals.currentUser as Human).audacity.toString(),
                      textAlign: TextAlign.center,
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