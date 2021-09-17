import 'package:flutter/material.dart';
import 'package:gemma/views/signin.dart';
import 'package:gemma/views/signin_educator.dart';
import 'package:gemma/views/signin_parents.dart';
import 'package:gemma/widget/widget.dart';

class Welcome extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemma'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.0,bottom: 20.0),
              //child: Text('Test',style: TextStyle(color: Colors.white),),
              child: Image.asset(
                "assets/images/logo.png",
                height: 230,
                width: 320,
              ),
            ),
            Container(
              //height: MediaQuery.of(context).size.height - 60,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Sign in as?',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22,
                            ),
                            //style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInParent(),
                            ),
                          );
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
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Parents",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            //style: biggerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInEducator(),
                            ),
                          );
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
                           // color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Educator",
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
                      SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}