import 'dart:convert';
import 'package:doctor_app/models/assistant.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/api_calls/urls.dart';

class ApiAssistant {
  static Future<List<Assistant>> getAllAssistantsByDoc(id) async {
    List<Assistant> listAssistant = [];
    final response = await http.get('${URLS.BASE_URL}/doc/assistants/' + id,
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data) {
        listAssistant.add(Assistant.fromJson(i));
      }
    }
    return listAssistant;
  }

  static Future<int> activateAssistant(id) async {
    final body = {};
    final response = await http.patch(
        '${URLS.BASE_URL}/doc/updateStateAssistant/' + id,
        body: jsonEncode(body),
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.statusCode;
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.statusCode;
    }
  }

  static Future<String> addAssistant(body) async {
    final response = await http.post('${URLS.BASE_URL}/doc/addAssistant',
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
