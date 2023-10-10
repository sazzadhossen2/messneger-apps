
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/constant.dart';
import 'package:messanger/roundat.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat.dart';

class Loginscreen extends StatefulWidget {
//  const Loginscreen({super.key});
static const String id ="Login Screen";
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _auth =FirebaseAuth.instance;
  String email ="";
  String password=" ";
  bool swapscreen=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(inAsyncCall: swapscreen,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
    child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Hero(tag: "logo",
              child: SizedBox(
                height: 200,
                child: Image.asset("assets/images/logos.jpg"),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              onChanged: (value){
                email =value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: Ktextfild.copyWith(
                hintText: "Enter Your email"
              ),

            ),
            SizedBox(height: 8,),
            TextField(
              onChanged: (value){
                password=value;
              },
              obscureText: true,
              decoration: Ktextfild.copyWith(
                hintText: "Enter with password",

              ),
            ),
            SizedBox(height: 24,),
         Roundatbutton(color: Colors.lightBlueAccent, title:"Login",
             onpress:()async{
           setState(() {
             swapscreen =true;
           });
               try{
                 final user=await   _auth.signInWithEmailAndPassword(email: email, password: password);
                 if(user!=null){
                   setState(() {
                     swapscreen=false;
                   });
                   Navigator.pushNamed(context,ChatScreen.id );
                 }}catch(e){
                 print(e);
               }
             })
         /*   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.lightBlueAccent,
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(onPressed: (){},
                minWidth: 200.0,
                  height: 42.0,
                  child: Text("Login"),
                ),
              ),
            )*/
          ],
        ),


        ),
      )
    );
  }
}
