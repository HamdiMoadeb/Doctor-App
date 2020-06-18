import 'package:doctor_app/api_calls/urls.dart';

class Wallet {
  Wallet(
    this.idPatient,
    this.id,
    this.description,
    this.amount,
    this.date,
    this.fullnamePatient,
    this.imagePatient,
    this.createdBy,
  );

  String idPatient;
  String id;
  String description;
  String amount;
  String date;
  String fullnamePatient;
  String imagePatient;
  String createdBy;

  Wallet.fromJson(Map<String, dynamic> json)
      : idPatient = json['idPatient'].toString(),
        id = json['_id'].toString(),
        description = json['description'].toString(),
        amount = json['amount'].toString(),
        date = json['date'].toString(),
        fullnamePatient = json['fullnamePatient'].toString(),
        imagePatient = URLS.BASE_URL + '/' + json['imagePatient'].toString(),
        createdBy = json['createdBy'].toString();
}
