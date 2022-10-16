import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'contact_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final form_key = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  var gender;
  final dateinput = TextEditingController();
  List userData = [];
  DateTime? currentBackPressTime;
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("User Details"),
          backgroundColor:Colors.indigo.shade900,
        ),
        body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                  key: form_key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text.rich(TextSpan(
                          text: 'Full Name ',
                          style: TextStyle(fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Colors.red.shade600),
                            )
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Your name is required';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text.rich(TextSpan(
                          text: 'Age',
                          style: TextStyle(fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Colors.red.shade500),
                            )
                          ])),
                      //for Email Address
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Your age is required';
                          } else
                            return null;
                        },
                      ),

                      SizedBox(height: 30,),
                      Text.rich(TextSpan(
                          text: 'Date of Birth ',
                          style: TextStyle(fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Colors.red.shade500),
                            )
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: dateinput,
                        decoration: InputDecoration(
                          hintText: 'dd-MM-yyyy',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        readOnly: true,
                        onTap: ()  async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              dateinput.text = formattedDate;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of Birth is required';
                          }else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text.rich(TextSpan(
                          text: 'Gender',
                          style: TextStyle(fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Colors.red.shade500),
                            )
                          ])),
                      RadioListTile(
                        title: Text("Male"),
                        value: "male",
                        groupValue: gender,
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                            print(gender);
                          });
                        }
                      ),

                      RadioListTile(
                        title: Text("Female"),
                        value: "female",
                        groupValue: gender,
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                            print(gender);
                          });
                        },
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(onPressed: (){
                        if(gender!="male"&&gender!="female"){
                          Fluttertoast.showToast(
                            msg: "Please select your gender", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.CENTER, // location
                            timeInSecForIosWeb: 1, // duration
                          );
                        }
                        if(form_key.currentState!.validate()&&gender=="male"||gender=="female"){
                          Map<String, String> value = {
                            "name": _name.text,
                            "age": _age.text,
                            "DateOfBirth": dateinput.text,
                            "gender": gender
                          };

                          debugPrint("value ==========> ${value.toString()}");
                          userData.add(value);
                          userDetails();

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Contact_info()));
                        }
                      }, style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.indigo.shade900)),
                          child: Text("Next"))),
                ]),
              ),
            ),
          ),
      ),
    );
  }
  Future<void> userDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    debugPrint(
        "jsonEncode(datainfo) ========> ${jsonEncode(userData.toString())}");
    pref.setString("userData", jsonEncode(userData).toString());
  }
}
