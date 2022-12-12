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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: loadWidgets(),
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
  List<Widget> loadWidgets(){
    if(Globals.currentUser?.email != null){
      return loadHumanWidgets();
    }
    else{
      return  loadGodWidgets();
    }
  }
  List<Widget> loadGodWidgets(){
    var widgetList = <Widget>[];
    widgetList.add(
        Column(
        children:  [
          TextButton(
              onPressed: (){
                context.push('/questmakerpage');
              },
              child: const Text("Make quests",
                style: TextStyle(
                  color: Colors.black,
                )
            ),
          )
        ],
      )
    );
    widgetList.add(
        Column(
          children:  [
            TextButton(
              onPressed: (){
                context.push('/questassignerpage');
              },
              child: const Text("Assign quests",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    );
    widgetList.add(
        Column(
          children:  [
            TextButton(
              onPressed: (){
                context.push('/humancreatorpage');
              },
              child: const Text("Create Humans",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    );
    if(Globals.currentUser?.name == "Hades"){
      widgetList.add(
          Column(
            children:  [
              TextButton(
                onPressed: (){
                  context.push('/borntodiepage');
                },
                child: const Text("Born to die",
                    style: TextStyle(
                      color: Colors.black,
                    )
                ),
              )
            ],
          )
      );
      widgetList.add(
          Column(
            children:  [
              TextButton(
                onPressed: (){
                  context.push('/contemplatethedeadpage');
                },
                child: const Text("Contemplate the dead",
                    style: TextStyle(
                      color: Colors.black,
                    )
                ),
              )
            ],
          )
      );
    }

    return widgetList;
  }
  List<Widget> loadHumanWidgets(){
    var widgetList = <Widget>[];
    widgetList.add(
        Column(
          children:  [
            TextButton(
              onPressed: (){
              },
              child: const Text("Resolve quests",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    );
    widgetList.add(
        Column(
          children:  [
            TextButton(
              onPressed: (){
                context.go("/attributesPage");
              },
              child: const Text("Attributes",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    );
    widgetList.add(
        Column(
          children:  [
            TextButton(
              onPressed: (){
              },
              child: const Text("Create Humans",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    );

    return widgetList;
  }

}