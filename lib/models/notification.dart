import 'package:doctor_app/api_calls/urls.dart';

class NotificationR {
  NotificationR(
    this.etat,
    this.createdAt,
    this.id,
    this.idApp,
    this.date,
    this.heure,
    this.createdBy,
  );

  int etat;
  String createdAt;
  String id;
  String idApp;
  String date;
  int heure;
  String createdBy;

  NotificationR.fromJson(Map<String, dynamic> json)
      : etat = int.parse(json['etat'].toString()),
        createdAt = json['createdAt'].toString(),
        id = json['_id'].toString(),
        idApp = json['idApp'].toString(),
        date = json['date'].toString(),
        heure = int.parse(json['heure'].toString()),
        createdBy = json['createdBy'].toString();
}
