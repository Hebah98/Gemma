import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gemma/views/chatrooms.dart';
import 'package:gemma/views/mainscreen.dart';
import 'package:gemma/views/signup.dart';
import 'package:gemma/views/splashscreen.dart';
import 'package:gemma/views/welcome.dart';
import 'helper/authenticate.dart';
import 'helper/helperfunctions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primaryColor: Color(0xffe06b11),
      scaffoldBackgroundColor: Color(0xffffffff),
      primarySwatch: Colors.orange,
    ),
    //home: SignIn(),
    //home: SignUp(),
    //home: Authenticate(),
    /*
      home: userIsLoggedIn != null ? /**/ userIsLoggedIn ? ChatRoom() : Authenticate() /**/
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
      */
    home: SplashScreen(),
    //home: MainScreen(),

  );
  }
}







