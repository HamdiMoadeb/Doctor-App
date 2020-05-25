import 'package:flutter/material.dart';
import 'package:doctor_app/models/patient.dart';
import 'package:doctor_app/screens/patient_details_page.dart';

class ItemCardPatient extends StatelessWidget {
  ItemCardPatient(
      {@required this.context, @required this.index, @required this.listdvs});

  final BuildContext context;
  final int index;
  final List<Patient> listdvs;

  @override
  Widget build(BuildContext context) {
    Patient patient = listdvs[index];
    return Container(
      child: Card(
        child: InkWell(
          onTap: () {
            print(patient.firstname);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientDetails(
                  patient: patient,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(patient.photourl),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          patient.firstname + ' ' + patient.lastname,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          patient.email,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.today,
                      color: Colors.redAccent,
                      size: 17.0,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      patient.birthday,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    new Spacer(),
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 18.0,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      patient.phone,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.green,
                      ),
                    ),

                    /*CircleAvatar(
                      radius: 18.0,
                      backgroundImage: AssetImage('images/phoneicon.png'),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
