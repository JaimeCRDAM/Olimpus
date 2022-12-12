// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idk/models/users/gods/God.dart';

import '../models/Const.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';
import '../services/UserServiceImpl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final UserServiceImpl _userServiceImpl;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _userServiceImpl = UserServiceImpl();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => selfLogin());
  }

  void selfLogin(){
    var tempMail = Globals.log;
    var tempPass = Globals.pass;
    User user = tempMail.contains("@") ? Human(null, tempMail, tempPass) : God(tempMail, tempPass);
    _userServiceImpl.loginUser(user).then((value) {
      try{
        if(value){
          context.replace("/mainpage");
        }
      }catch(e){
        Globals.showSnackBar("Invalid data", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Olimpus App"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                hintText: "Email",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    context.go('/signup');
                  },
                  child: const Text("Register",
                      style: TextStyle(
                        color: Colors.black,
                      )
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    User user = _email.text.contains("@") ? Human(null, _email.text, _password.text) : God(_email.text, _password.text);
                    /*await _userServiceImpl.loginUser(user);
                    if(Globals.currentUser == null) {
                      Globals.showSnackBar("Invalid data", context);
                      return;
                    }
                    context.replace("/mainpage");*/
                    try{
                        selfLogin();
                      }catch(e){
                        Globals.showSnackBar("Invalid data", context);
                      }
                  },
                  child: const Text("Login",
                      style: TextStyle(
                        color: Colors.black,
                      )
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}