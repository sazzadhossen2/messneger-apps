
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/constant.dart';
import 'package:messanger/screen/chat.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../roundat.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Regstationscreen extends StatefulWidget {
  const Regstationscreen({super.key});
  static const String id ="Regstation Screen";

  @override
  State<Regstationscreen> createState() => _RegstationscreenState();
}

class _RegstationscreenState extends State<Regstationscreen> {

  final _auth=FirebaseAuth.instance;
  String email="";
  String password="";
  bool swapspinner =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(inAsyncCall: swapspinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset("assets/images/logos.jpg"),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
              onChanged: (value){
                email=value;
              },keyboardType: TextInputType.emailAddress,
                decoration: Ktextfild.copyWith(
                  hintText: "Enter your Email"
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                onChanged: (value){
                  password=value;
                },obscureText: true,
                decoration: Ktextfild.copyWith(
                hintText: "Enter you password",
              ),),
              SizedBox(
                height: 24,
              ),
     Roundatbutton(color:Colors.blueAccent,onpress: ()async{
       setState(() {
         swapspinner=true;
       });
           try{
    final newUser=await   _auth.createUserWithEmailAndPassword(
               email: email, password: password);
    if(newUser!=null){
      setState(() {
        swapspinner=false;
      });
          Navigator.pushNamed(context,ChatScreen.id );
    }}catch(e){
             print(e);
           }
     },title: "Regstation",)

            ],
          ),
        ),
      ),
    );
  }
}
