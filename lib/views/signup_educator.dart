import 'package:flutter/material.dart';
import 'package:gemma/helper/helperfunctions.dart';
import 'package:gemma/services/auth.dart';
import 'package:gemma/services/database.dart';
import 'package:gemma/views/chatrooms.dart';
import 'package:gemma/views/signin.dart';
import 'package:gemma/views/signin_educator.dart';
import 'package:gemma/views/signin_parents.dart';
import 'package:gemma/views/welcome.dart';
import 'package:gemma/widget/widget.dart';

class SignUpEducator extends StatefulWidget {
  //final Function toggle;
  //SignUp(this.toggle);
  @override
  _SignUpEducatorState createState() => _SignUpEducatorState();
}

class _SignUpEducatorState extends State<SignUpEducator> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  HelperFunctions helperFunctions = new HelperFunctions();
  singMeUp(){
    if (formKey.currentState.validate()) {
      Map<String,String> userInfoMap = {
        "name" : usernameEditingController.text,
        "email" : emailEditingController.text,
        "category":'educator',
      };
      HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
      setState(() {
        isLoading = true;
      });
      authService.signUpWithEmailAndPassword(emailEditingController.text, passwordEditingController.text).then((val) {
        print('$val');

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        )
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      appBar: AppBar(
        title: Text('Sign Up As Educator'),
      ),
      body: isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          if(val.isEmpty || val.length <4){
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        controller: usernameEditingController,
                        /*validator: (val) {
                          return val.isEmpty || val.length < 3
                              ? "Enter Username 3+ characters"
                              : null;
                        }

                         */
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Username"),
                      ),
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
                       /* validator: (val) {
                          return val.length < 6
                              ? "Enter Password 6+ characters"
                              : null;
                        },

                        */
                        obscureText: true,
                        controller: passwordEditingController,
                        decoration: textFieldInputDecoration("Password"),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                        /*
                        validator: (val) {
                          return val.isEmpty
                              ? "Enter your Experiences please"
                              : null;
                        },
                         */

                        decoration: textFieldInputDecoration("Experiences"),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                        /*
                        validator: (val) {
                          return val.isEmpty
                              ? "Enter your Phone Number please"
                              : null;
                        },
                         */
                        decoration: textFieldInputDecoration("Phone Number"),
                        style: simpleTextStyle(),
                      ),
                      TextFormField(
                        /*
                        validator: (val) {
                          return val.isEmpty
                              ? "Enter your Work Hours please"
                              : null;
                        },
                         */

                        decoration: textFieldInputDecoration("Work Hours"),
                        style: simpleTextStyle(),
                      ),
                      /*
                      TextFormField(
                        /*
                        validator: (val) {
                          return val.isEmpty
                              ? "Enter your CV please"
                              : null;
                        },
                         */
                        obscureText: true,
                        //controller: passwordEditingController,
                        decoration: textFieldInputDecoration("CV"),
                        //style: TextStyle(color: Colors.orange),
                        style: simpleTextStyle(),
                      ),
                      */
                    ],
                  ),
                ),
                SizedBox(

                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    /*
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                      //style: TextStyle(color: Colors.white),
                    ),
                    */
                  ),
                ),
                SizedBox(

                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    singMeUp();
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
                      "Sign Up",
                      style: biggerTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(

                  height: 10,
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

                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Already have account ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                      //style: biggerTextStyle(),
                    ),
                    GestureDetector(
                      onTap: (){
                        //widget.toggle();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInEducator()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Signin Now',
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

                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}