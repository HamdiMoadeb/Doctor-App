import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:doctor_app/api_calls/api_patient.dart';
import 'package:doctor_app/models/patient.dart';

class SearchableDrop extends StatefulWidget {
  SearchableDrop({Key key, this.callback, this.patientSelected})
      : super(key: key);

  Function(String) callback;
  Patient patientSelected;

  @override
  _MyAppState createState() => _MyAppState(patientSelected: patientSelected);
}

class _MyAppState extends State<SearchableDrop> {
  _MyAppState({this.patientSelected});
  Patient patientSelected;
  bool asTabs = false;
  String selectedValue;
  final List<DropdownMenuItem> items = [];

  List<Patient> patientsL = [];

  String getPatientId(String name) {
    String id = "";
    for (Patient pat in patientsL) {
      String full = pat.firstname + ' ' + pat.lastname;
      if (full == name) {
        id = pat.id;
      }
    }
    return id;
  }

  void _allPatients() {
    if (patientSelected != null) {
      setState(() {
        items.add(
          DropdownMenuItem(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(patientSelected.photourl),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  patientSelected.firstname + ' ' + patientSelected.lastname,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            value: patientSelected.firstname + ' ' + patientSelected.lastname,
          ),
        );

        selectedValue =
            patientSelected.firstname + ' ' + patientSelected.lastname;
        print('====>' + selectedValue);
      });
    } else {
      ApiPatient.getAllPatients().then((patients) => {
            patientsL = patients,
            for (Patient pat in patients)
              {
                setState(() {
                  items.add(
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(pat.photourl),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            pat.firstname + ' ' + pat.lastname,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      value: pat.firstname + ' ' + pat.lastname,
                    ),
                  );
                }),
              }
          });
    }
  }

  @override
  void initState() {
    _allPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, SearchableDropdown> widgets;
    widgets = {
      "Patients": SearchableDropdown(
        items: items,
        value: selectedValue,
        closeButton: 'Fermer',
        hint: "Sélectionner un patient",
        searchHint: "Chercher",
        onChanged: (value) {
          setState(() {
            widget.callback(getPatientId(value));
            selectedValue = value;
          });
        },
        isExpanded: true,
        disabledHint: 'Loading..',
      ),
    };

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: widgets
            .map((k, v) {
              return (MapEntry(
                k,
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                    ),
                    margin: EdgeInsets.all(0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Text("$k:"),
                          v,
                        ],
                      ),
                    ),
                  ),
                ),
              ));
            })
            .values
            .toList(),
      ),
    );
  }
}
