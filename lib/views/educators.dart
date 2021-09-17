import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemma/helper/constants.dart';
import 'package:gemma/services/auth.dart';
import 'package:gemma/services/database.dart';
import 'package:gemma/views/chatrooms.dart';
import 'package:gemma/views/conversation_screen.dart';
import 'package:gemma/views/mainscreen.dart';
import 'package:gemma/views/welcome.dart';
import 'package:gemma/widget/widget.dart';
import 'package:rating_dialog/rating_dialog.dart';
class Educator extends StatefulWidget {
  @override
  _EducatorState createState() => _EducatorState();
}

class _EducatorState extends State<Educator> {
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  QuerySnapshot searchSnapshot;
  Widget searchList() {
    return searchSnapshot != null ?ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
          );
        }):Container(

    );
  }
  initiateSearch() {
    databaseMethods.getUserByCat('educator').then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                //style: biggerTextStyle(),
                style: TextStyle(color: Colors.orange),
              ),
              Text(
                userEmail,
               // style: biggerTextStyle(),
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: () {
                rating();
              },
              child: Container(
                margin: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Rating",
                  style: biggerTextStyle(),
                ),
              )),
        ],
      ),
    );
  }
  @override
  void initState() {
    //initiateSearch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educators'),
        actions: [
          GestureDetector(
            onTap: () {
              authService.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              //color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Educators",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      //initiateSearch();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007E55),
                            const Color(0xff2A7555)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Map",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffAA7555),
                            const Color(0xffAA7555)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Search",
                        style: biggerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }

  void rating() {
    showDialog(
        context: context,
        builder: (context){
          return RatingDialog(
            // your app's name?
            title: 'Evaluation',
            // encourage your user to leave a high rating?
            message:
            'Please type name of user and evaluate his work',
            // your app's logo?
            image: const FlutterLogo(size: 100),
            submitButton: 'Submit',
            onCancelled: () => print('cancelled'),
            onSubmitted: (response) {
              Map<String,dynamic> MapRating = {
                "rating" : response.rating,
                "comment" : response.comment,
              };
              print('Evaluation: ${response.rating}, comment: ${response.comment}');
              FirebaseFirestore.instance.collection("Evaluation").add(MapRating).catchError((e) {
                print(e.toString());
              });

              // TODO: add your own logic
              if (response.rating < 3.0) {
                // send their comments to your email or anywhere you wish
                // ask the user to contact you instead of leaving a bad review
              } else {

              }
            },
          );
        }
    );
  }
}
