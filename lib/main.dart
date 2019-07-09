import 'package:flutter/material.dart';
import 'package:jepret/constants/JepretColor.dart';
import 'package:jepret/routes/WelcomeRoute.dart';
import 'package:jepret/routes/RegisterRoute.dart';
import 'package:jepret/routes/HomeRoute.dart';
import 'package:jepret/pages/home/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: JepretColor.PRIMARY,
        primaryColorDark: JepretColor.PRIMARY_DARKER,
        backgroundColor: JepretColor.APP_BACKGROUND_LIGHT,
        fontFamily: "NunitoSans"
      ),
      home: HomeRoute(),
    );
  }
}