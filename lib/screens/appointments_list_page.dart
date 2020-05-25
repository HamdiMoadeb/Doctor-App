import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';

class AppointmentsList extends StatefulWidget {
  @override
  AppointmentsListState createState() => new AppointmentsListState();
}

class AppointmentsListState extends State<AppointmentsList> {
  //final List<Appointment> listRDVs = [];

  DateTime datePicked;
  DateTime selectedDate = DateTime.now();

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
                  padding: EdgeInsets.all(10.0),
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
