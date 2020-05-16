import 'package:doctor_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/components/form_register.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:doctor_app/api_calls/api_auth.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var fullnameController = TextEditingController();
  var phoneController = TextEditingController();
  var specualtyController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  ProgressDialog pr;

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
                padding: EdgeInsets.only(top: 25.0, left: 40.0),
                child: Image.asset('images/doctor.png'),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 70.0, right: 28.0, left: 28.0),
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
                    height: ScreenUtil().setHeight(140),
                  ),
                  FormRegister(
                    fullname: fullnameController,
                    phone: phoneController,
                    email: emailController,
                    speciality: specualtyController,
                    address: addressController,
                    password: passwordController,
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
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                pr.show();

                                final body = {
                                  "fullname":
                                      fullnameController.text.toString(),
                                  "phone": phoneController.text.toString(),
                                  "email": emailController.text.toString(),
                                  "speciality":
                                      specualtyController.text.toString(),
                                  "address": addressController.text.toString(),
                                  "password":
                                      passwordController.text.toString(),
                                };
                                ApiAuth.register(body).then((success) {
                                  String response = json
                                      .decode(success)['response']
                                      .toString();
                                  if (response == 'true') {
                                    pr.hide().whenComplete(() {
                                      //TODO show success message (Toast)
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
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
                                  'REGISTER',
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
