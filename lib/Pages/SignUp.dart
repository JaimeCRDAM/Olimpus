// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../models/Const.dart';
import '../models/users/humans/Human.dart';
import '../services/UserServiceImpl.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => SignUp();
}

class SignUp extends State<SignUpPage> {

  late final TextEditingController _email;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final UserServiceImpl _userServiceImpl;


  @override
  void initState() {
    _email = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _userServiceImpl = UserServiceImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Olimpus App"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                  hintText: "Email"
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                hintText: "Username",
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
              textAlign: TextAlign.center,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextButton(
              onPressed: () async {
                Human human = Human(_username.text, _email.text, _password.text);
                await _userServiceImpl.registerHuman(human);
                if(Globals.currentUser == null) {
                  Globals.showSnackBar("Invalid data", context);
                  return;
                }
                await _userServiceImpl.loginUser(human);
                Globals.showSnackBar("Welcome ${Globals.currentUser?.name}", context);
                context.replace("/mainpage");
              },
              child: const Text("Register",
                  style: TextStyle(
                    color: Colors.black,
                  )
              ),
            ),
        ])
    );
  }
}

