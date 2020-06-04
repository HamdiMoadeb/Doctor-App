import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAddAssistance extends StatefulWidget {
  FormAddAssistance({
    Key key,
    @required this.fullname,
    @required this.phone,
    @required this.email,
  }) : super(key: key);

  final TextEditingController fullname;
  final TextEditingController phone;
  final TextEditingController email;

  @override
  FormAddAssistanceState createState() => FormAddAssistanceState(
        fullname: fullname,
        phone: phone,
        email: email,
      );
}

class FormAddAssistanceState extends State<FormAddAssistance> {
  FormAddAssistanceState({
    @required this.fullname,
    @required this.phone,
    @required this.email,
  });

  final TextEditingController fullname;
  final TextEditingController phone;
  final TextEditingController email;
  String labelText = '';

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;

    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(700),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            )
          ]),
      child: Padding(
        padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ajouter Assistante',
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: ScreenUtil().setSp(45),
                letterSpacing: .6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'Fullname',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: fullname,
              decoration: InputDecoration(
                hintText: 'firstname',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'Email',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'email',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'Phone',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: phone,
              decoration: InputDecoration(
                hintText: 'phone',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
          ],
        ),
      ),
    );
  }
}
