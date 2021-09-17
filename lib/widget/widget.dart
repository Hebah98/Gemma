import 'package:flutter/material.dart';
Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.png",
      height: 50,
    ),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.orange),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)));
}
TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.orange, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white , fontSize: 17);
}