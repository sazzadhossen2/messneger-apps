import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/screen/chat.dart';
import 'package:messanger/screen/login.dart';
import 'package:messanger/screen/regstation.dart';
import 'package:messanger/screen/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
late FirebaseApp app;
late FirebaseAuth auth;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  app =await Firebase.initializeApp();
  auth =FirebaseAuth.instanceFor(app: app);
  runApp(Flashchat());

}
class Flashchat extends StatelessWidget {
  const Flashchat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      initialRoute:Wellcome.id ,
      routes: {
        Wellcome.id:(context)=>Wellcome(),
        Regstationscreen.id:(context)=>Regstationscreen(),
        Loginscreen.id:(context)=>Loginscreen(),
        ChatScreen.id:(context)=>ChatScreen(),

      },
    );
  }
}
