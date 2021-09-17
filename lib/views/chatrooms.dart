import 'package:flutter/material.dart';
import 'package:gemma/helper/authenticate.dart';
import 'package:gemma/helper/constants.dart';
import 'package:gemma/helper/helperfunctions.dart';
import 'package:gemma/services/auth.dart';
import 'package:gemma/views/educators.dart';
import 'package:gemma/views/search.dart';
import 'package:gemma/views/welcome.dart';
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthService authService = new AuthService();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemma'),
        actions: [
          GestureDetector(
            onTap: () {
              //authService.signOut();
              //Navigator.pushReplacement(
              //  context, MaterialPageRoute(builder: (context) => SignIn()));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Educator()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        },
      ),
    );
  }
}