import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Pages/HomePage.dart';
import 'Pages/SignUp.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Dem',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routerConfig: GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpPage();
                },
              ),
            ],
          ),
        ],
      )
    );
  }
}