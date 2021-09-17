import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gemma/helper/constants.dart';
import 'package:gemma/services/database.dart';
import 'package:gemma/views/conversation_screen.dart';
import 'package:gemma/widget/widget.dart';
import 'package:rating_dialog/rating_dialog.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();

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
            //Future work
    );
  }
  initiateSearch() {
    databaseMethods.getUserByUsername(searchEditingController.text).then((val) {
//print(val.toString());
//searchSnapshot = val;
//print(searchSnapshot.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

//create chatroom, send user to conversation screen, pushreplacement
  createChatroomAndStartConversation({String userName}){
    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId" : chatRoomId,
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> ConversationScreen(chatRoomId)
      ));
    }else{
      print("you can not send message to yourself");
    }
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
                style: TextStyle(color: Colors.orange),
                // style: biggerTextStyle(),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.orange),
                // style: biggerTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(
                  userName: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Msg",
                style: biggerTextStyle(),
              ),
            ),

          ),
         /* GestureDetector(
              onTap: () {
               // rating();
              },
              child: Container(
                margin: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Rating",
                  style: biggerTextStyle(),
                ),
              )),

          */
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
        title: Text('Search'),
      ),
      //appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.orangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search username...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                      //databaseMethods.getUserByUsername(searchEditingController.text).then((val){print(val.toString());});
                      if(searchSnapshot.docs.length == 0){
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Search Problem'),
                              content: Text('This user is not exist\nplease try again'),
                            )
                        );
                      }
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xffe06b11),
                              const Color(0xffe06b11),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png")
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

 /* void rating() {
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

  */
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}