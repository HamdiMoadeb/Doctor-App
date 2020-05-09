import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'https://node-docapp.herokuapp.com/doc';
}

class ApiAuth {
  static Future<List<dynamic>> getEmployees() async {
    final response = await http.get('${URLS.BASE_URL}/all');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<String> login(body) async {
    final response = await http.post('${URLS.BASE_URL}/login',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<String> forgot_password(body) async {
    final response = await http.post('${URLS.BASE_URL}/forgotPassword',
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
