import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gemma/helper/helperfunctions.dart';
import 'package:gemma/services/auth.dart';
import 'package:gemma/services/database.dart';
import 'package:gemma/views/chatrooms.dart';
import 'package:gemma/views/signup.dart';
import 'package:gemma/views/signup_educator.dart';
import 'package:gemma/views/welcome.dart';
import 'package:gemma/widget/widget.dart';
class SignInEducator extends StatefulWidget {
  //final Function toggle;
  //SignIn(this.toggle);
  @override
  _SignInEducatorState createState() => _SignInEducatorState();
}

class _SignInEducatorState extends State<SignInEducator> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signIn() async {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailEditingController.text);
      //HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
      setState(() {
        isLoading = true;
      });
      databaseMethods.getUserByUserEmail(emailEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
      });
      authService
          .signInWithEmailAndPassword(
          emailEditingController.text, passwordEditingController.text)
          .then((val) {
        if (val != null) {

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }else{
          print('there is a problem in e-mail or password');
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Error Message'),
                content: Text('There is a problem in e-mail or password\nPlz try again'),
              )
          );
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      appBar: AppBar(
        title: Text('SignIn as Educator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          if(val.isEmpty || !val.contains('@')){
                            return 'Please Enter a valid e-mail address';
                          }
                          return null;
                        },
                        /*validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                              ? null
                              : "Enter correct email";
                        },

                         */

                        controller: emailEditingController,
                        decoration: textFieldInputDecoration("Email"),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                        validator: (val){
                          if(val.isEmpty || val.length < 7){
                            return 'Password must be at least 7 characters';
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passwordEditingController,
                        decoration: textFieldInputDecoration("Password"),
                        style: simpleTextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  /*Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 17,
                        ),
                        //style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                   */
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      signIn();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff1899d0),
                            const Color(0xff02609e),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Sign In",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff4e7f04),
                            const Color(0xffabcc06),
                          ],
                        ),
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Go To Welcome Page",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Do not have an account ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                       //style: biggerTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          //widget.toggle();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpEducator()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            ' Register Now',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
