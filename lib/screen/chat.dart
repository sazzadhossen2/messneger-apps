// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
final _firstore= FirebaseFirestore.instance;
 User? Loginuser;
class ChatScreen extends StatefulWidget {
  static const  String id="Chat Screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth =FirebaseAuth.instance;

  TextEditingController textcontroller =TextEditingController();
  String messagest ="";
  void getCurrentuser(){
    try{
final user= _auth.currentUser;
if(user!=null){
  Loginuser=user;
  print(Loginuser?.email);
}
  }catch(e){
      print(e);
    }
  }
  void getMessages()async{
    final messages =await _firstore.collection('messages').get();

    for(var message in messages.docs){
      print(message.data());
    }
  }
  void getMessageStrem()async{
   await for(var snapshort in _firstore.collection('messages').snapshots()){}
  }
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  //  getMessages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
         Messagestrem(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                      onChanged: (value) {
                        messagest =value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(textStyle: kSendButtonTextStyle),
                    onPressed: (){
                      textcontroller.clear();
                      _firstore.collection("messages").add({
                        'text':messagest,
                        'sender':Loginuser?.email
                      });
                    },

                    child: Text(
                      'Send',

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Messagestrem extends StatelessWidget {
  const Messagestrem({super.key});

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder<QuerySnapshot>(
        stream:  _firstore.collection('messages').snapshots(),
        builder: (context,snapshot){

          if(snapshot.hasData){
            final messages =snapshot.data!.docs.reversed;
            List<Massagebabul> messagewidget=[];
            for(var message in messages){

              final messagetext =message['text'];
              final messagesender =message['sender'];
              final currentuser = Loginuser?.email;

              messagewidget.add(
                  Massagebabul(text: messagetext,
                      sender: messagesender,
                  ismymassage: currentuser==messagesender,
                  )
              );
            }
            return Expanded(
              child:   ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20
                ),
                children: messagewidget,

              ),
            );
          }else{
            return SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            );
          }
        });

  }
}


class Massagebabul extends StatelessWidget {
  const Massagebabul({super.key, required this.text, required this.sender,this.ismymassage=false});
final String text;
final String sender;
final bool ismymassage ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:ismymassage? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(fontSize: 12),),
          Material(
            color:ismymassage? Color(0xFF006AFF):Colors.lightBlueAccent,
            borderRadius:ismymassage? BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ): BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(

                text,style: TextStyle(fontSize: 17,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

