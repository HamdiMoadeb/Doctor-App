import 'package:doctor_app/api_calls/api_appointment.dart';
import 'package:doctor_app/api_calls/api_patient.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/appointment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:doctor_app/models/ChipData.dart';
import 'package:doctor_app/models/Dayparting.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class RescheduleAppointment extends StatefulWidget {
  RescheduleAppointment({
    @required this.appointment,
  });

  final Appointment appointment;

  @override
  RescheduleAppointmentState createState() =>
      new RescheduleAppointmentState(appointment: appointment);
}

class RescheduleAppointmentState extends State<RescheduleAppointment> {
  RescheduleAppointmentState({
    @required this.appointment,
  });

  var descController = TextEditingController();
  Appointment appointment;

  bool isSelected = false;
  bool status = false;
  ProgressDialog pr;

  DateTime selectedDate = DateTime.now();

  List<ChipData> chipsData = [
    //Matin
    ChipData('8:00 AM', false, true, 0),
    ChipData('8:30 AM', false, true, 0),
    ChipData('9:00 AM', false, true, 0),
    ChipData('9:30 AM', false, true, 0),
    ChipData('10:00 AM', false, true, 0),
    ChipData('10:30 AM', false, true, 0),
    ChipData('11:00 AM', false, true, 0),
    ChipData('11:30 AM', false, true, 0),
    //Midi
    ChipData('12:00 PM', false, true, 1),
    ChipData('12:30 PM', false, true, 1),
    ChipData('1:00 PM', false, true, 1),
    ChipData('1:30 PM', false, true, 1),
    ChipData('2:00 PM', false, true, 1),
    ChipData('2:30 PM', false, true, 1),
    ChipData('3:00 PM', false, true, 1),
    ChipData('3:30 PM', false, true, 1),
    //Soir
    ChipData('4:00 PM', false, true, 2),
    ChipData('4:30 PM', false, true, 2),
    ChipData('5:00 PM', false, true, 2),
    ChipData('5:30 PM', false, true, 2),
    ChipData('6:00 PM', false, true, 2),
    ChipData('6:30 PM', false, true, 2),
    ChipData('7:00 PM', false, true, 2),
    ChipData('7:30 PM', false, true, 2),
  ];

  List<Dayparting> vehicles = [
    new Dayparting(
      'Matin  ',
      '8 AM - 12 PM',
      ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
      Icons.motorcycle,
    ),
    new Dayparting(
      'Après Midi  ',
      '12 PM - 4 PM',
      ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
      Icons.directions_car,
    ),
    new Dayparting(
      'Soir  ',
      '4 PM - 8 PM',
      ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
      Icons.directions_car,
    ),
  ];

  getHoursByDate(String date) {
    final body = {
      "date": date.toString(),
    };
    ApiAppointment.getHoursByDate(body).then((success) {
      List<dynamic> list = json.decode(success);
      for (dynamic i in list) {
        print('getHoursByDate : $i');
        setState(() {
          chipsData[i].enabled = false;
        });
      }
    });
  }

  int getChipClicked(String time) {
    for (var i = 0; i < chipsData.length; i++) {
      if (chipsData[i].time == time) {
        print('clicked : $i');
        return i;
      } else {
        chipsData[i].selected = false;
      }
    }
  }

  int getSelectedChip() {
    int selected = -1;
    for (var i = 0; i < chipsData.length; i++) {
      if (chipsData[i].selected == true) {
        selected = i;
      }
    }
    return selected;
  }

  setChipNotSelected(int index) {
    for (var i = 0; i < chipsData.length; i++) {
      if (i != index) {
        chipsData[i].selected = false;
      }
    }
  }

  setAllChipsEnabled() {
    for (var i = 0; i < chipsData.length; i++) {
      chipsData[i].enabled = true;
    }
  }

  RawChip getChip(int chipindex, int rowNb) {
    ChipData chipData;
    if (rowNb == 0) {
      chipData = chipsData[chipindex];
    } else if (rowNb == 1) {
      chipData = chipsData[chipindex + 8];
    } else {
      chipData = chipsData[chipindex + 16];
    }

    return RawChip(
      label: Text(
        chipData.time,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      backgroundColor: Colors.grey.shade500,
      selected: chipData.selected,
      checkmarkColor: Colors.black45,
      isEnabled: chipData.enabled,
      disabledColor: Colors.grey.shade300,
      selectedColor: Colors.blue,
      onSelected: (bool isSelected) {
        setState(() {
          int index = getChipClicked(chipData.time);
          if (index != null) {
            if (chipsData[index].selected == true) {
              chipsData[index].selected = false;
            } else {
              setChipNotSelected(index);
              chipsData[index].selected = true;
            }
          }
        });
      },
      showCheckmark: false,
    );
  }

  String getHour(int index) {
    switch (index) {
      case 0:
        return '8:00 AM';
      case 1:
        return '8:30 AM';
      case 2:
        return '9:00 AM';
      case 3:
        return '9:30 AM';
      case 4:
        return '10:00 AM';
      case 5:
        return '10:30 AM';
      case 6:
        return '11:00 AM';
      case 7:
        return '11:30 AM';
      case 8:
        return '12:00 PM';
      case 9:
        return '12:30 PM';
      case 10:
        return '1:00 PM';
      case 11:
        return '1:30 PM';
      case 12:
        return '2:00 PM';
      case 13:
        return '2:30 PM';
      case 14:
        return '3:00 PM';
      case 15:
        return '3:30 PM';
      case 16:
        return '4:00 PM';
      case 17:
        return '4:30 PM';
      case 18:
        return '5:00 PM';
      case 19:
        return '5:30 PM';
      case 20:
        return '6:00 PM';
      case 21:
        return '6:30 PM';
      case 22:
        return '7:00 PM';
      case 23:
        return '7:30 PM';
    }
  }

  Container tagLabel(int tagId) {
    String label;
    Color textColor;
    Color bgColor;
    if (tagId == 1) {
      label = 'ACTIVE';
      textColor = Colors.green;
      bgColor = Colors.green.shade100;
    } else if (tagId == 2) {
      label = 'RESCHEDULED';
      textColor = Colors.orange;
      bgColor = Colors.yellowAccent.shade100;
    } else if (tagId == 3) {
      label = 'CANCELLED';
      textColor = Colors.red;
      bgColor = Colors.red.shade100;
    } else if (tagId == 4) {
      label = 'DONE';
      textColor = Colors.grey.shade700;
      bgColor = Colors.grey.shade400;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
      color: bgColor,
      child: Text(
        label,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 17.0,
          color: textColor,
        ),
      ),
    );
  }

  String daysIndication(DateTime dateTime) {
    final date2 = DateTime.now();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (aDate == today) {
      return 'Today';
    } else if (dateTime.isBefore(date2)) {
      final difference = date2.difference(dateTime).inDays;
      if (difference == 0) {
        return 'Yesterday';
      } else {
        return '$difference days ago';
      }
    } else if (dateTime.isAfter(date2)) {
      final difference = dateTime.difference(date2).inDays;
      var diff = difference + 1;
      if (diff == 1) {
        return 'Tomorrow';
      } else {
        return 'in $diff days';
      }
    }
  }

  String email = '...';
  String phone = '...';
  int etat;
  bool visiblityReschdule;
  bool visiblityFinish;
  bool visiblityCancel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoursByDate(selectedDate.toString());

    etat = appointment.etat;
    if (etat == 1) {
      visiblityReschdule = true;
      visiblityFinish = true;
      visiblityCancel = true;
    } else if (etat == 2) {
      visiblityReschdule = false;
      visiblityFinish = true;
      visiblityCancel = true;
    } else {
      visiblityReschdule = false;
      visiblityFinish = false;
      visiblityCancel = false;
    }

    ApiPatient.getPatientById(appointment.idPatient).then((onValue) {
      setState(() {
        email = onValue.email;
        phone = onValue.phone;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getDocId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('idDoc');
      return token;
    }

    DateTime dateTime = DateTime.parse(appointment.date);
    String dateRDV = new DateFormat.yMd('fr_FR').format(dateTime).toString();
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    double cWidthName = MediaQuery.of(context).size.width * 0.6;

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reporter rendez-vous'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    radius: 38.0,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 36.0,
                      backgroundImage: NetworkImage(appointment.imagePatient),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: cWidthName,
                        child: Text(
                          appointment.namePatient,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: cWidthName,
                        child: Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Text(
                          'Patient phone',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        width: 250.0,
                        child: Text(
                          phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => launch("tel://" + phone),
                    child: CircleAvatar(
                      radius: 22.0,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Text(
                          'Description RDV',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        width: cWidth,
                        child: Text(
                          appointment.description,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 16.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Text(
                  'New Date and Time',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    // backgroundColor: Color(0x29ED34E3),
                    fontSize: 15.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              DatePickerTimeline(
                selectedDate,
                height: 82.0,
                locale: 'fr',
                onDateChange: (date) {
                  setAllChipsEnabled();
                  getHoursByDate(date.toString());
                  setState(() {
                    selectedDate = date;
                  });
                  print(date);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  return new ExpansionTile(
                    title: Container(
                      height: 25.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            vehicles[i].title,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            vehicles[i].time,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              getChip(0, i),
                              getChip(1, i),
                              getChip(2, i),
                              getChip(3, i),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              getChip(4, i),
                              getChip(5, i),
                              getChip(6, i),
                              getChip(7, i),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 20.0,
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
                            pr.show();
                            String createdby = await getDocId();

                            final body = {
                              "idApp": appointment.id,
                              "reportedBy": createdby,
                              "date": selectedDate.toString(),
                              "heure": getSelectedChip(),
                            };
                            ApiAppointment.reportAppointment(body)
                                .then((success) {
                              //String response = json.decode(success)['response'].toString();
                              if (success == 200) {
                                pr.hide().whenComplete(() {
                                  //TODO show success message (Toast)
                                  if (Navigator.canPop(context)) {
                                    var count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ == 2;
                                    });
                                  } else {
                                    SystemNavigator.pop();
                                  }
                                });
                              } else {
                                pr.hide().whenComplete(() {
                                  //TODO show error message (Toast)
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  } else {
                                    SystemNavigator.pop();
                                  }
                                });
                              }
                              return;
                            });
                          },
                          child: Center(
                            child: Text(
                              'REPORTER',
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
            ],
          ),
        ),
      ),
    );
  }
}
