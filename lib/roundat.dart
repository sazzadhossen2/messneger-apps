
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Roundatbutton extends StatelessWidget {
  const Roundatbutton({super.key, required this.color, required this.title, required this.onpress});
  final Color color;
  final String title;
  final VoidCallback onpress;
  @override


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(

        color: color,
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            minWidth: 200.0,
            height: 30,
            child: Text(title,style: TextStyle(color: Colors.white),),
              onPressed:onpress
          )),
    );
  }
}
