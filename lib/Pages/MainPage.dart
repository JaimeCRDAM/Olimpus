import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/Const.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Globals.userServiceImpl.logOut(Globals.currentUser!).then((value) => context.replace("/"));
                    },
                    icon: const Icon(IconData(0xe3b3, fontFamily: 'MaterialIcons')),
                  ),
                  IconButton(
                    onPressed: () {
                      context.push('/userpage');
                    },
                    icon: const Icon(Icons.account_box),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}