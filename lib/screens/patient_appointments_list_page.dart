import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';
import 'package:doctor_app/models/patient.dart';

class PatientAppointments extends StatefulWidget {
  PatientAppointments({@required this.patient, @required this.type});
  Patient patient;
  String type;

  @override
  _PatientAppointmentsState createState() =>
      _PatientAppointmentsState(patient: patient, type: type);
}

class _PatientAppointmentsState extends State<PatientAppointments> {
  _PatientAppointmentsState({@required this.patient, @required this.type});
  Patient patient;
  String type;

  FutureBuilder callData() {
    if (type == 'Upcoming visits') {
      return FutureBuilder(
        future: ApiAppointment.getAllNewAppointmentsByPatient(patient.id),
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
      );
    } else {
      return FutureBuilder(
        future: ApiAppointment.getAllOldAppointmentsByPatient(patient.id),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type),
      ),
      body: callData(),
    );
  }
}
