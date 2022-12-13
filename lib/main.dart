import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idk/Pages/HumanPages/AttributesPage.dart';
import 'package:idk/Pages/godpages/Hades/BornToDiePage.dart';
import 'package:idk/Pages/godpages/Hades/ContemplateTheDeadPage.dart';
import 'package:idk/Pages/godpages/HumanCreatorPage.dart';
import 'package:idk/Pages/godpages/QuestAsignerPage.dart';
import 'package:idk/Pages/UserPage.dart';

import 'Pages/HumanPages/ResolveQuestsPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/MainPage.dart';
import 'Pages/SignUp.dart';
import 'Pages/godpages/QuestMakerPage.dart';

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
              return const LoginPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpPage();
                },
              ),
              GoRoute(
                path: 'mainpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const MainPage();
                },
              ),
              GoRoute(
                path: 'questmakerpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const QuestMakerPage();
                },
              ),
              GoRoute(
                path: 'userpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const UserPage();
                },
              ),
              GoRoute(
                path: 'questassignerpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const QuestAsignerPage();
                },
              ),
              GoRoute(
                path: 'humancreatorpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const HumanCreatorPage();
                },
              ),
              GoRoute(
                path: 'borntodiepage',
                builder: (BuildContext context, GoRouterState state) {
                  return const BornToDiePage();
                },
              ),
              GoRoute(
                path: 'contemplatethedeadpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const ContemplateTheDeadPage();
                },
              ),
              GoRoute(
                path: 'attributesPage',
                builder: (BuildContext context, GoRouterState state) {
                  return const AttributesPage();
                },
              ),
              GoRoute(
                path: 'resolvequestpage',
                builder: (BuildContext context, GoRouterState state) {
                  return const ResolveQuestsPage();
                },
              ),
            ],
          ),
        ],
      )
    );
  }
}