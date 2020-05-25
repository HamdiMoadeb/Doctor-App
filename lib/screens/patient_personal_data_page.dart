import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:doctor_app/models/patient.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientPersonalData extends StatefulWidget {
  PatientPersonalData({
    @required this.patient,
  });

  final Patient patient;

  @override
  PatientPersonalDataState createState() =>
      new PatientPersonalDataState(patient: patient);
}

class PatientPersonalDataState extends State<PatientPersonalData> {
  PatientPersonalDataState({
    @required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Personal information'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 52.0,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(patient.photourl),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  patient.firstname + ' ' + patient.lastname,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        leading: Icon(
                          OMIcons.phone,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.phone,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          OMIcons.email,
                          //Icons.check_box,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.email,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          OMIcons.home,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.address,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          OMIcons.calendarToday,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.birthday,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          OMIcons.people,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.gender,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          OMIcons.workOutline,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          patient.profession,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      ListTile(),
                    ],
                  ).toList()),
            ),
          )
        ],
      ),
    );
  }
}
