import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviesapp/homepage/homeScreen.dart';
import 'package:moviesapp/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Image(
        image: AssetImage("assets/images/splash.png"),
        fit: BoxFit.fill,
            width: double.infinity,
      )),
    );
  }
}
