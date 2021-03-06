import 'dart:convert';
import 'package:doctor_app/models/appointment.dart';
import 'package:doctor_app/models/notification.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/api_calls/urls.dart';

class ApiNotification {
  static Future<List<NotificationR>> getAllNotification() async {
    List<NotificationR> listNotification = [];
    final response = await http.get('${URLS.BASE_URL}/request',
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data['requests']) {
        listNotification.add(NotificationR.fromJson(i));
      }
    }
    return listNotification;
  }

  static Future<String> getNbNotification() async {
    String nb = '0';
    final response = await http.get('${URLS.BASE_URL}/request',
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      nb = data['count'].toString();
      print(data['count'].toString());
    }
    return nb;
  }

  static Future<String> cancelNotification(id) async {
    final body = {};
    final response = await http.patch('${URLS.BASE_URL}/request/refuse/' + id,
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<String> validateNotification(id) async {
    final body = {};
    final response = await http.patch('${URLS.BASE_URL}/request/accept/' + id,
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
