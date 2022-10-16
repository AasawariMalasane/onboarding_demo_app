import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'display_page.dart';

class EducationDetail extends StatefulWidget {
  const EducationDetail({Key? key}) : super(key: key);

  @override
  State<EducationDetail> createState() => _EducationDetailState();
}

class _EducationDetailState extends State<EducationDetail> {
  final form_key = GlobalKey<FormState>();
  final last_eduation = TextEditingController();
  final _college = TextEditingController();
  final _grade = TextEditingController();
  List userEducationinfo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor:Colors.indigo.shade900,
          title: Text("Education Details",)),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: form_key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                          text: 'Your last education ',
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
                        controller: last_eduation,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Your last education is required';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text.rich(TextSpan(
                          text: 'Your College/University ',
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
                        controller: _college,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Your College/University is required';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text.rich(TextSpan(
                          text: 'Grade',
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
                        controller: _grade,
                        maxLength: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Grade is required';
                          }else
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
                                "lasteduation": last_eduation.text,
                                "college": _college.text,
                                "grade": _grade.text,
                              };

                              debugPrint("value ==========> ${value.toString()}");
                              userEducationinfo.add(value);
                              userEducationDetails();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayInfo()));
                            }
                          },style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.indigo.shade900,)),
                              child: Text("Submit"))),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> userEducationDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    debugPrint(
        "jsonEncode(userEducationinfo) ========> ${jsonEncode(userEducationinfo.toString())}");
    pref.setString("userEducationinfo", jsonEncode(userEducationinfo).toString());
  }
}
