import 'package:doctor_app/api_calls/api_assistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/components/form_add_assistance.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AddAssistance extends StatefulWidget {
  @override
  AddAssistanceState createState() => AddAssistanceState();
}

class AddAssistanceState extends State<AddAssistance> {
  var fullnameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    Future<String> getDocId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('idDoc');
      return token;
    }

    pr = new ProgressDialog(context, isDismissible: false);
    pr.style(
        message: 'Please wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    ScreenUtil.init(context);
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Assistante'),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 40.0),
                child: Image.asset('images/doctor.png'),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 70.0, right: 28.0, left: 28.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(180),
                  ),
                  FormAddAssistance(
                    fullname: fullnameController,
                    phone: phoneController,
                    email: emailController,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil().setWidth(330),
                          height: ScreenUtil().setHeight(90),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Colors.blue,
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0,
                                ),
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                pr.show();
                                String createdby = await getDocId();
                                final body = {
                                  "fullname":
                                      fullnameController.text.toString(),
                                  "phone": phoneController.text.toString(),
                                  "email": emailController.text.toString(),
                                  "createdBy": createdby,
                                };
                                ApiAssistant.addAssistant(body).then((success) {
                                  String response = json
                                      .decode(success)['response']
                                      .toString();
                                  if (response == 'true') {
                                    pr.hide().whenComplete(() {
                                      //TODO show success message (Toast)
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      } else {
                                        SystemNavigator.pop();
                                      }
                                    });
                                  } else {
                                    String message = json
                                        .decode(success)['message']
                                        .toString();
                                    pr.hide().whenComplete(() {
                                      print(message);
                                      //TODO show error message (Toast)
                                    });
                                  }
                                  return;
                                });
                              },
                              child: Center(
                                child: Text(
                                  'AJOUTER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 18.0,
                                      letterSpacing: 1.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
