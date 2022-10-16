import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onboarding_demo_app/user_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserDetail())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color:  Colors.indigo.shade900,
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: Colors.white),),
              SizedBox(height: 10,),
              Text("ONBOARDING",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
            ],
          ),
        ),

    );
  }
}
