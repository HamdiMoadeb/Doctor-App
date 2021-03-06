import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctor_app/api_calls/urls.dart';
import 'package:dio/dio.dart';

class ApiAuth {
  static Future<String> login(body) async {
    final response = await http.post('${URLS.BASE_URL}/doc/login',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<String> register(body) async {
    final response = await http.post('${URLS.BASE_URL}/doc/register',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<String> uploadPhoto(formdata, id) async {
    Dio dio = new Dio();
    dio.patch('${URLS.BASE_URL}/doc/updateInfo/' + id,
            data: formdata,
            options: Options(method: 'PATCH', responseType: ResponseType.json))
        .then((response) {
      print('&&&&&&&&&&&&&&&&&&&&&&$response');
      return response;
    }).catchError((error) {
      print('&&&&&&&&&&&&&&&&&&&&&&$error');
      return error;
    });
  }

  static Future<int> editProfileDoc(body, id) async {
    final response = await http.patch('${URLS.BASE_URL}/doc/updateInfo/' + id,
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.statusCode;
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.statusCode;
    }
  }

  static Future<String> forgot_password(body) async {
    final response = await http.post('${URLS.BASE_URL}/doc/forgotPassword',
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
