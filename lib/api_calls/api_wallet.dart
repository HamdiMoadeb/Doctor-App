import 'dart:convert';
import 'package:doctor_app/models/appointment.dart';
import 'package:doctor_app/models/notification.dart';
import 'package:doctor_app/models/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_app/api_calls/urls.dart';

class ApiWallet {
  static Future<List<Wallet>> getAllWallet(id) async {
    List<Wallet> listWallet = [];
    final response = await http.get('${URLS.BASE_URL}/wallet/' + id,
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data) {
        listWallet.add(Wallet.fromJson(i));
      }
    }
    return listWallet;
  }

  static Future<List<Wallet>> getAllWalletByPatient(id) async {
    List<Wallet> listWallet = [];
    final response = await http.get('${URLS.BASE_URL}/wallet/patient/' + id,
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (Map i in data) {
        listWallet.add(Wallet.fromJson(i));
      }
    }
    return listWallet;
  }

  static Future<String> addWallet(body) async {
    final response = await http.post('${URLS.BASE_URL}/wallet/add',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<String> deleteWallet(id) async {
    final response = await http.delete('${URLS.BASE_URL}/wallet/' + id,
        headers: {"Content-type": "application/json"});
    if (response.statusCode == 404) {
      print(response.body);
      return response.body.toString();
    } else if (response.statusCode == 200) {
      print(response.body);
      return response.body.toString();
    }
  }
}
