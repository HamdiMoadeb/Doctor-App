import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';

class AppointmentsList extends StatefulWidget {
  AppointmentsList({this.selectedDate});

  final DateTime selectedDate;

  @override
  AppointmentsListState createState() =>
      new AppointmentsListState(selectedDate: selectedDate);
}

class AppointmentsListState extends State<AppointmentsList> {
  AppointmentsListState({this.selectedDate});

  DateTime selectedDate;
  DateTime datePicked;
  //DateTime selectedDate = DateTime.now();

  callbackDate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DatePickerTimeline(
          selectedDate,
          height: 85.0,
          locale: 'fr',
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
        Expanded(
          child: FutureBuilder(
            future: ApiAppointment.getAllAppointmentsByDay({
              "date": selectedDate.toString(),
            }),
            builder: (context, snapshot) {
              print(snapshot.data);
              final listRDVs = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (BuildContext context, int index) => ItemCard(
                    context: context,
                    index: index,
                    listdvs: listRDVs,
                  ),
                  itemCount: listRDVs.length,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
