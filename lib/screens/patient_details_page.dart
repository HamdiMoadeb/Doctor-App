import 'package:doctor_app/screens/patient_appointments_list_page.dart';
import 'package:doctor_app/screens/patient_personal_data_page.dart';
import 'package:doctor_app/screens/wallet_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:doctor_app/models/patient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor_app/screens/add_appointment_page.dart';

class PatientDetails extends StatefulWidget {
  PatientDetails({
    @required this.patient,
  });

  final Patient patient;

  @override
  PatientDetailsState createState() =>
      new PatientDetailsState(patient: patient);
}

class PatientDetailsState extends State<PatientDetails> {
  PatientDetailsState({
    @required this.patient,
  });

  final Patient patient;

  _launchURL(String toMailId, String subject, String body) async {
    String url =
        Uri.encodeFull('mailto:hello@domain.com?subject=$subject&body=$body');
    //var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Details Patient'),
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
                  height: 3.0,
                ),
                Text(
                  patient.profession,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => _launchURL(patient.email, '', ''),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Email',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => launch("tel://" + patient.phone),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.yellow.shade700,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Phone',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAppointment(
                                    patient: patient,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.add_to_photos,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Ajouter',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientAppointments(
                                patient: patient,
                                type: 'Upcoming visits',
                              ),
                            ),
                          );
                        },
                        leading: Icon(
                          OMIcons.indeterminateCheckBox,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          'Upcoming visits',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientAppointments(
                                patient: patient,
                                type: 'Previous visits',
                              ),
                            ),
                          );
                        },
                        leading: Icon(
                          OMIcons.checkBox,
                          //Icons.check_box,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          'Previous visits',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PatientPersonalData(
                                patient: patient,
                              ),
                            ),
                          );
                        },
                        leading: Icon(
                          OMIcons.permContactCalendar,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          'Personal information',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WalletPatientPage(
                                patient: patient,
                              ),
                            ),
                          );
                        },
                        leading: Icon(
                          OMIcons.monetizationOn,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          'Paiements',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
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
