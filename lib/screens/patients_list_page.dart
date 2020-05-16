import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card_patient.dart';
import 'package:doctor_app/api_calls/api_patient.dart';
import 'package:doctor_app/models/patient.dart';

class PatientsList extends StatefulWidget {
  @override
  PatientsListState createState() => new PatientsListState();
}

class PatientsListState extends State<PatientsList> {
  List<Patient> patients = List<Patient>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiPatient.getAllPatients(),
      builder: (context, snapshot) {
        final patients = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (BuildContext context, int index) => ItemCardPatient(
              context: context,
              index: index,
              listdvs: patients,
            ),
            itemCount: patients.length,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
