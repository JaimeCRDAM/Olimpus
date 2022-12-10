

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:idk/services/UserServiceImpl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/Const.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late final TextEditingController _password;
  late final UserServiceImpl _userServiceImpl;
  late Image imageShown;
  late File imgFile;
  bool saveImg = false;
  bool savePwd = true;

  @override
  void initState() {
    _password = TextEditingController();
    _userServiceImpl = UserServiceImpl();
    final currentUser = Globals.currentUser;
    if (currentUser != null){
      imageShown = Image.network(Globals.storage+currentUser.avatar, key: UniqueKey());
    }

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
                        obscureText: true,
                      )
                    ),
                    TextButton(
                      onPressed: savePwd ? (){
                        _userServiceImpl.updatePassword(Globals.currentUser!, _password.text).then((value){
                          if(value != null){
                            Globals.showSnackBar("Password changed", context);
                            return;
                          }
                          Globals.showSnackBar("An error ocurred, try again later", context);
                        });
                      }: null,
                        child: const Text("Save")
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Email"),
                    Text(
                      Globals.currentUser?.email != null ? Globals.currentUser?.email as String : "You are a GOD",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Avatar"),
                    Column(
                      children: [
                        Container(
                            height: 200,
                            width: 400,
                            child:imageShown
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  _getFromCamera().then((value) {
                                    if (value != null) {
                                      setState(() {
                                        imgFile = File(value.path);
                                        imageShown = Image.file(imgFile, key: UniqueKey());
                                      });
                                      saveImg = true;
                                    }
                                  });
                                },
                                child: const Text("Camera")
                            ),
                            TextButton(
                                onPressed: (){
                                  _getFromGallery().then((value) {
                                    if (value != null) {
                                      setState(() {
                                        imgFile = File(value.path);
                                        imageShown = Image.file(imgFile, key: UniqueKey());
                                      });
                                      saveImg = true;
                                    }
                                  });
                                },
                                child: const Text("Gallery")
                            )
                          ],
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: saveImg ? (){
                          print(_userServiceImpl.updateAvatar(Globals.currentUser!, imgFile));
                        }: null,
                        child: const Text("Save"),
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
  Future<XFile?> _getFromGallery() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }
  Future<XFile?> _getFromCamera() async {
    return await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  }

}