import 'package:doctor_app/api_calls/urls.dart';

class NotificationR {
  NotificationR(
    this.etat,
    this.id,
    this.idApp,
    this.fullnamePatient,
    this.imagePatient,
    this.description,
    this.olddate,
    this.newdate,
    this.oldheure,
    this.newheure,
    this.createdAt,
    this.createdBy,
  );

  int etat;
  String id;
  String idApp;
  String fullnamePatient;
  String imagePatient;
  String description;
  String olddate;
  String newdate;
  int oldheure;
  int newheure;
  String createdAt;
  String createdBy;

  NotificationR.fromJson(Map<String, dynamic> json)
      : etat = int.parse(json['etat'].toString()),
        id = json['_id'].toString(),
        idApp = json['idApp'].toString(),
        fullnamePatient = json['fullnamePatient'].toString(),
        imagePatient = URLS.BASE_URL + '/' +json['imagePatient'].toString(),
        description = json['description'].toString(),
        olddate = json['olddate'].toString(),
        newdate = json['newdate'].toString(),
        oldheure = int.parse(json['oldheure'].toString()),
        newheure = int.parse(json['newheure'].toString()),
        createdAt = json['createdAt'].toString(),
        createdBy = json['createdBy'].toString();
}
