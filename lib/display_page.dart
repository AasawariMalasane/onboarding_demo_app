import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DisplayInfo extends StatefulWidget {
  const DisplayInfo({Key? key}) : super(key: key);

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  List userData=[];
  List userContactData=[];
  List userEducationData=[];
  DateTime? currentBackPressTime;
  @override
  void initState() {
    super.initState();
    getUserDetail();
  }
  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Tap back again to exit");
        return Future.value(false);
      }
      return exit(0);
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
              height: 500,
              width: 350,
              decoration: BoxDecoration(
                  color: Color(0xffe8e5fa),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(blurRadius: 10)]
              ),child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("Your Details",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                      SizedBox(height: 40,),
                      Text("Name : ${userData.last['name']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Age : ${userData.last['DateOfBirth']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("DOB : ${userData.last['gender']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Mobile Number : ${userContactData.last['number']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Whatsapp Number : ${userContactData.last['wpNumber']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Email : ${userContactData.last['emailData']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Last Education : ${userEducationData.last['lasteduation']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("College/University : ${userEducationData.last['college']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),
                      Text("Grade : ${userEducationData.last['grade']}",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 15,),

                ]),
              ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
  void getUserDetail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      debugPrint("pref getString ========>${pref.getString("userData")}");
      userData = jsonDecode(pref.getString("userData").toString());
      userContactData = jsonDecode(pref.getString("userContactinfo").toString());
      userEducationData = jsonDecode(pref.getString("userEducationinfo").toString());
      debugPrint("userData========>${userData}");
      debugPrint("userData========>${userContactData}");
      debugPrint("userData========>${userEducationData}");
    });
  }
}

