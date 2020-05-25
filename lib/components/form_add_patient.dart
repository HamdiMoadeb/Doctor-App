import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/components/radio_gender.dart';
import 'package:doctor_app/components/datepicker_input.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class FormAddPatientStful extends StatefulWidget {
  FormAddPatientStful({
    Key key,
    @required this.firstname,
    @required this.lastname,
    @required this.callbackBirth,
    @required this.address,
    @required this.profession,
    @required this.phone,
    @required this.email,
    @required this.callbackGender,
  }) : super(key: key);

  final TextEditingController firstname;
  final TextEditingController lastname;
  final Function(String) callbackBirth;
  final TextEditingController address;
  final TextEditingController profession;
  final TextEditingController phone;
  final TextEditingController email;
  final Function(String) callbackGender;

  @override
  FormAddPatient createState() => FormAddPatient(
        firstname: firstname,
        lastname: lastname,
        callbackBirth: callbackBirth,
        phone: phone,
        email: email,
        profession: profession,
        address: address,
        callbackGender: callbackGender,
      );
}

class FormAddPatient extends State<FormAddPatientStful> {
  FormAddPatient({
    @required this.firstname,
    @required this.lastname,
    @required this.callbackBirth,
    @required this.address,
    @required this.profession,
    @required this.phone,
    @required this.email,
    @required this.callbackGender,
  });

  final TextEditingController firstname;
  final TextEditingController lastname;
  String birthday =
      new DateFormat.yMd('fr_FR').format(DateTime.now()).toString();
  final TextEditingController address;
  final TextEditingController profession;
  final TextEditingController phone;
  final TextEditingController email;
  String gender = 'Female';
  Function(String) callbackBirth;
  Function(String) callbackGender;

  String labelText = '';
  DateTime selectedDate = DateTime.now();
  ValueChanged<DateTime> selectDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthday = new DateFormat.yMd('fr_FR').format(picked).toString();
        callbackBirth(birthday);
      });
  }

  callback(newAbc) {
    setState(() {
      gender = newAbc;
      callbackGender(gender);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;

    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(1420),
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
              'Ajouter Patient',
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
              'Firstname',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: firstname,
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
              'Lastname',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: lastname,
              decoration: InputDecoration(
                hintText: 'lastname',
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
            Text(
              'Gender',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            RadioGender(
              callback: callback,
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
              'Birthday',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            DatePickerInput(
                labelText: labelText,
                valueText: new DateFormat.yMMMd().format(selectedDate),
                valueStyle: valueStyle,
                onPressed: () => _selectDate(context)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'Profession',
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: ScreenUtil().setSp(26),
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: profession,
              decoration: InputDecoration(
                hintText: 'profession',
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
