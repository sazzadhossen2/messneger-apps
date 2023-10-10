
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/screen/login.dart';
import 'package:messanger/screen/regstation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Wellcome extends StatefulWidget {
static const  String id ="Wellcome Screen";
 // const Wellcome({super.key});

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {

    super.initState();

    controller =AnimationController(
        duration: Duration(seconds: 1),
        vsync: this);
    animation=ColorTween(begin: Colors.cyan,end: Colors.white).animate(controller);
  controller.forward();
  controller.addListener(() {
    setState(() {

    });
  });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: Image.asset("assets/images/logos.jpg"),
              ),
              SizedBox(width: 0.8,),
              DefaultTextStyle(style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.w900
              ), child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                TyperAnimatedText("Fairbase Chat")
              ],

              )
              )
            ],
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
                  color: Colors.lightBlueAccent,
borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    minWidth: 200,
                      height: 42,
                      child: Text("Login"),
                      onPressed:(){
                      Navigator.pushNamed(context, Loginscreen.id);
                      } )),
          ),

SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(

                color: Colors.blueAccent,
borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  minWidth: 200,
                    height: 42,
                    child: Text("Regstation"),
                    onPressed: (){
Navigator.pushNamed(context, Regstationscreen.id);
                    })),
          )
        ],
      ),
    );
  }
}
