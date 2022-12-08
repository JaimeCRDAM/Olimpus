import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idk/models/users/gods/God.dart';

import '../models/Const.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';
import '../services/UserServiceImpl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final UserServiceImpl _userServiceImpl;

  @override
  void initState() {
    _email = TextEditingController();
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
                    //var tempMail = "qaq@email.com";
                    var tempMail = "Jedediah Thompson";
                    //var tempPass = "qqqqqqqq";
                    var tempPass = "p";
                    User user = tempMail.contains("@") ? Human(null, tempMail, tempPass) : God(tempMail, tempPass);
                    Globals.currentUser = await _userServiceImpl.loginUser(user);
                    if(Globals.currentUser == null) {
                      Globals.showSnackBar("Invalid data", context);
                    }
                    Globals.showSnackBar("Welcome ${Globals.currentUser?.name}", context);
                    return;
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