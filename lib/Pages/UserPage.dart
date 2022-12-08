import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idk/models/Utils/Camera/Camera.dart';

import '../models/Const.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late final TextEditingController _password;

  @override
  void initState() {
    _password = TextEditingController();
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
                    const Text("Username"),
                    Text(
                      Globals.currentUser?.name as String,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const Text("Password"),
                    IntrinsicWidth(
                      child: TextField(
                        controller: _password,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'New password'
                        ),
                      )
                    ),
                    TextButton(
                      onPressed: (){
                        Globals.showSnackBar("Save pressed", context);
                      },
                      child: const Text("Save")
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Avatar"),
                    Image.network('https://picsum.photos/250?image=9'),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            late final photo;
                            await availableCameras().then(
                              (value) {
                                photo = Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) =>
                                        CameraPage(cameras: value))
                                );
                              }
                            );
                            Globals.showSnackBar("Save pressed", context);
                          },
                          child: const Text("Camera")
                        ),
                        TextButton(
                            onPressed: (){
                              Globals.showSnackBar("Save pressed", context);
                            },
                            child: const Text("Phone")
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Username"),
                    Expanded(
                        child: Text(
                          Globals.currentUser?.name as String,
                          textAlign: TextAlign.center,
                        )
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Username"),
                    Expanded(
                        child: Text(
                          Globals.currentUser?.name as String,
                          textAlign: TextAlign.center,
                        )
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