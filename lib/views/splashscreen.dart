import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gemma/views/welcome.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()
    {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color (0xffe16b10),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 150, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              width: 200,
              height: 210,
            ),
            Text(
                'Gemma',
               style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
             textAlign: TextAlign.center,
            ),
          ],
        ),
        ),
      );
  }
}
