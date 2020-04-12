import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(430),
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
              'Login',
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
              'Username',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'username',
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
              'Password',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Poppins-Medium',
                    fontSize: ScreenUtil().setSp(28),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
