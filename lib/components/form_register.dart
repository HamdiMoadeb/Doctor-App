import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormRegister extends StatelessWidget {
  FormRegister({
    @required this.fullname,
    @required this.phone,
    @required this.email,
    @required this.speciality,
    @required this.address,
    @required this.password,
  });

  final TextEditingController fullname;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController speciality;
  final TextEditingController address;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(920),
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
              'Register',
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
                hintText: 'fullname',
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
              'Specialty',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: speciality,
              decoration: InputDecoration(
                hintText: 'specialty',
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
              'Address',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: address,
              decoration: InputDecoration(
                hintText: 'address',
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
              controller: password,
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
          ],
        ),
      ),
    );
  }
}
