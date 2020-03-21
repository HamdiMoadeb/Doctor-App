import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool asTabs = false;
  String selectedValue;
  final List<DropdownMenuItem> items = [];

  List<String> patients = [
    'Hamdi Moadeb',
    'Mahmoud Ghandour',
    'Ayoub Ghozzi',
    'Donia Azib'
  ];

  @override
  void initState() {
    for (String pat in patients) {
      items.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    'https://careermetis.com/wp-content/uploads/2017/11/GC-ML-IMG_4366_009.jpg'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                pat,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          value: pat,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, SearchableDropdown> widgets;
    widgets = {
      "Patients": SearchableDropdown.single(
        items: items,
        value: selectedValue,
        hint: "Sélectionner un patient",
        searchHint: "chercher",
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        isExpanded: true,
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
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text("$k:"),
                                v,
                              ],
                            ),
                          )))));
            })
            .values
            .toList(),
      ),
    );
  }
}
