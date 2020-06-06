import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/components/searchable_dropdown.dart';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor_app/models/patient.dart';
import 'package:doctor_app/models/ChipData.dart';
import 'package:doctor_app/models/Dayparting.dart';

class AddAppointment extends StatefulWidget {
  AddAppointment({this.patient});

  final Patient patient;

  @override
  _State createState() => _State(patient: patient);
}

class _State extends State<AddAppointment> {
  _State({this.patient});

  final Patient patient;
  bool isSelected = false;
  bool status = false;

  ProgressDialog pr;
  DateTime selectedDate = DateTime.now();
  String patientId = "";
  var descController = TextEditingController();

  callbackPatient(newPat) {
    setState(() {
      //birthdayController = newPat;
      print('ID CALLBACK @@@@@ $newPat');
      patientId = newPat;
    });
  }

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

  void getHoursByDate(String date) {
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

  void setChipNotSelected(int index) {
    for (var i = 0; i < chipsData.length; i++) {
      if (i != index) {
        chipsData[i].selected = false;
      }
    }
  }

  void setAllChipsEnabled() {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoursByDate(selectedDate.toString());
  }

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un RDV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: SearchableDrop(
                  callback: callbackPatient,
                  patientSelected: patient,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
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
                height: 15.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  return new ExpansionTile(
                    title: Row(
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
                              "idPatient": patientId,
                              "createdBy": createdby,
                              "description": descController.text.toString(),
                              "date": selectedDate.toString(),
                              "heure": getSelectedChip(),
                            };
                            ApiAppointment.addAppointment(body).then((success) {
                              String response =
                                  json.decode(success)['response'].toString();
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
                                String message =
                                    json.decode(success)['message'].toString();
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
            ],
          ),
        ),
      ),
    );
  }
}
