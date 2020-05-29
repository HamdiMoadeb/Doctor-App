import 'package:flutter/material.dart';
import 'package:doctor_app/models/ChipData.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';
import 'dart:convert';
import 'package:doctor_app/models/Dayparting.dart';

class ChipsDaypartingChooser extends StatefulWidget {
  ChipsDaypartingChooser({Key key, this.callback, this.selectedDate})
      : super(key: key);

  Function(String) callback;
  DateTime selectedDate;

  @override
  ChipsDaypartingChooserState createState() => ChipsDaypartingChooserState(
      callback: callback, selectedDate: selectedDate);
}

class ChipsDaypartingChooserState extends State<ChipsDaypartingChooser> {
  ChipsDaypartingChooserState({this.callback, this.selectedDate});

  Function(String) callback;
  DateTime selectedDate;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoursByDate(selectedDate.toString());
  }

  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
