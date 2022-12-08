import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Pages/SignUp.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dem',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => const SignUpPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
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
        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/signup');
                  },
                child: const Text("Register",
                  style: TextStyle(
                    color: Colors.black,
                  )
                ),
              ),
              TextButton(
                  onPressed: () {},
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