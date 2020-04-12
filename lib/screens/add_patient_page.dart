import 'package:flutter/material.dart';
import 'package:doctor_app/components/searchable_dropdown.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: <Widget>[
            SearchableDrop(),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'État de santé',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
