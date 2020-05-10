import 'package:doctor_app/api_calls/api_auth.dart';
import 'package:doctor_app/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/components/form_login.dart';
import 'package:flutter/services.dart';
import 'package:doctor_app/screens/register_page.dart';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  var docPhoneController = TextEditingController();
  var docPassController = TextEditingController();
  ProgressDialog pr;

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );
  @override
  Widget build(BuildContext context) {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));
    ScreenUtil.init(context);
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0, left: 40.0),
                child: Image.asset('images/login.png'),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 85.0, right: 28.0, left: 28.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'DOCTOR APP',
                        style: TextStyle(
                          fontFamily: 'Poppins-Bold',
                          fontSize: ScreenUtil().setSp(46),
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(300),
                  ),
                  FormLogin(
                    docPhone: docPhoneController,
                    docPassword: docPassController,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      /*Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),*/
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
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                pr.show();

                                final body = {
                                  "phone": docPhoneController.text.toString(),
                                  "password": docPassController.text.toString(),
                                };
                                ApiAuth.login(body).then((success) {
                                  String response = json
                                      .decode(success)['response']
                                      .toString();
                                  if (response == 'true') {
                                    Doctor doctor = Doctor.fromJson(
                                        json.decode(success)['doc']);
                                    print(doctor.fullname);
                                    pr.hide().whenComplete(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    });
                                  } else {
                                    String message = json
                                        .decode(success)['message']
                                        .toString();
                                    pr.hide().whenComplete(() {
                                      showDialog(
                                        builder: (context) => AlertDialog(
                                          title: Text(message),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                docPhoneController.text = '';
                                                docPassController.text = '';
                                              },
                                              child: Text('OK'),
                                            )
                                          ],
                                        ),
                                        context: context,
                                      );
                                    });
                                  }
                                  return;
                                });
                              },
                              child: Center(
                                child: Text(
                                  'SIGNIN',
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
                    height: ScreenUtil().setHeight(70),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Or Create Account',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Poppins-Medium',
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    ),
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
