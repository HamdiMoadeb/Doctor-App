import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_app/components/datepicker_input.dart';
import 'package:doctor_app/components/searchable_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:doctor_app/models/patient.dart';
import 'dart:async';

class AddWallet extends StatefulWidget {
  AddWallet({this.patient});

  final Patient patient;
  @override
  AddWalletState createState() => AddWalletState();
}

class AddWalletState extends State<AddWallet> {
  AddWalletState({this.patient});

  final Patient patient;
  TextEditingController desc = TextEditingController();
  TextEditingController money = TextEditingController();
  String birthday = DateFormat.yMd('fr_FR').format(DateTime.now()).toString();
  String labelText = '';
  DateTime selectedDate = DateTime.now();
  ValueChanged<DateTime> selectDate;
  String patientId = "";

  callbackPatient(newPat) {
    setState(() {
      //birthdayController = newPat;
      print('ID CALLBACK @@@@@ $newPat');
      patientId = newPat;
    });
  }

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
        //callbackBirth(birthday);
      });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: SearchableDrop(
                      callback: callbackPatient,
                      patientSelected: patient,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Text(
                    'Montant',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: ScreenUtil().setSp(26),
                      letterSpacing: .6,
                    ),
                  ),
                  TextField(
                    controller: money,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'montant',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Text(
                    'Date',
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
                    'Description',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: ScreenUtil().setSp(26),
                      letterSpacing: .6,
                    ),
                  ),
                  TextField(
                    controller: desc,
                    decoration: InputDecoration(
                      hintText: 'description',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 200.0,
                          height: 50.0,
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
                                //  String createdby = await getDocId();

                                final body = {
                                  "idPatient": patientId,
                                  //  "createdBy": createdby,
                                  "description": desc.text.toString(),
                                  "date": selectedDate.toString(),
                                };
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
                    height: ScreenUtil().setHeight(40),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
