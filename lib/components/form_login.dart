import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/api_calls/api_auth.dart';

class FormLogin extends StatelessWidget {
  FormLogin({
    @required this.docPhone,
    @required this.docPassword,
  });

  final TextEditingController docPhone;
  final TextEditingController docPassword;

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Forgot Password'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "email"),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('SEND'),
                  onPressed: () {
                    final body = {
                      "email": _textFieldController.text.toString(),
                    };
                    ApiAuth.forgot_password(body).then((success) {
                      Navigator.pop(context);
                    });
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(515),
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
              'Phone',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: docPhone,
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
              'Password',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: docPassword,
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
              height: ScreenUtil().setHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => _displayDialog(context),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Poppins-Medium',
                      fontSize: ScreenUtil().setSp(28),
                    ),
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

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
