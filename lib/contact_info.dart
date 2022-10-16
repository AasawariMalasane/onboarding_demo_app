import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'educational_details.dart';

class Contact_info extends StatefulWidget {
  const Contact_info({Key? key}) : super(key: key);

  @override
  State<Contact_info> createState() => _Contact_infoState();
}

class _Contact_infoState extends State<Contact_info> {
  final form_key = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _wpnumber = TextEditingController();
  final _email = TextEditingController();
  List userContactinfo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor:Colors.indigo.shade900,
          title: Text("Contact Details",)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: form_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text.rich(TextSpan(
            text: 'Mobile Number ',
                style: TextStyle(fontSize: 16),
                children: <InlineSpan>[
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                        color: Colors.red.shade500),
                  )
                ])),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _number,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],
                  decoration: InputDecoration(
                    prefixText: '+91',
                    prefixStyle:
                    TextStyle(fontSize: 17),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (value.length != 10) {
                      return 'Enter valid Number';
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text.rich(TextSpan(
                    text: 'Whatsapp Number ',
                    style: TextStyle(fontSize: 16),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: Colors.red.shade500),
                      )
                    ])),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _wpnumber,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter. digitsOnly],
                  decoration: InputDecoration(
                    prefixText: '+91',
                    prefixStyle:
                    TextStyle(fontSize: 17),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Whatsapp number is required';
                    }
                    if (value.length != 10) {
                      return 'Enter valid Number';
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text.rich(TextSpan(
                    text: 'Email Address ',
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
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                    if (value == null || value.isEmpty) {
                      return 'Email address is required';
                    } else if (!regex.hasMatch(value)) {
                      return ("Please enter correct email");
                    } else
                      return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(onPressed: (){
                      if(form_key.currentState!.validate()){
                        Map<String, String> value = {
                          "number": _number.text,
                          "wpNumber": _wpnumber.text,
                          "emailData": _email.text,
                        };

                        debugPrint("value ==========> ${value.toString()}");
                        userContactinfo.add(value);
                        userContactDetails();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetail()));
                      }
                    }, style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.indigo.shade900,)),
                        child: Text("Next"))),
            ]),
          ),
        ),
      ),
    );
  }
  Future<void> userContactDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    debugPrint(
        "jsonEncode(userContactinfo) ========> ${jsonEncode(userContactinfo.toString())}");
    pref.setString("userContactinfo", jsonEncode(userContactinfo).toString());
  }
}

