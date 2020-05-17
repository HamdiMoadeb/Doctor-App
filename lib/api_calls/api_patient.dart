import 'dart:convert';
import 'package:doctor_app/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/api_calls/urls.dart';

class ApiPatient {
  static Future<List<Patient>> getAllPatients() async {
    List<Patient> listPatients = [];

    final response = await http.get('${URLS.BASE_URL}/patient');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map i in data) {
        listPatients.add(Patient.fromJson(i));
      }
      return listPatients;
    } else {
      return listPatients;
    }
  }

  static Future<String> addPatient(body) async {
    final response = await http.post('${URLS.BASE_URL}/patient/add',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }
}
