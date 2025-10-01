import 'package:flutter/material.dart';
import 'package:find_the_spy/screens/home.dart';
import 'package:find_the_spy/screens/help.dart';
import 'package:find_the_spy/screens/players.dart';
import 'package:find_the_spy/screens/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 34, 1),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/help": (context) => HelpPage(),
        "/players": (context) => Players(),
        "/about": (context) => AboutPage(),
      },
    );
  }
}