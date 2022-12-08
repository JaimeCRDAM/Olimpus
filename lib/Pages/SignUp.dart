import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUp();
}

class SignUp extends State<SignUpPage> {


  late final TextEditingController _email;
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
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
              controller: _password,
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
            ),
            TextButton(
              onPressed: () async {
                    (){};
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