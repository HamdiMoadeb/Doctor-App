import 'package:doctor_app/api_calls/urls.dart';

class Appointment {
  Appointment(
    this.etat,
    this.createdAt,
    this.id,
    this.idPatient,
    this.imagePatient,
    this.namePatient,
    this.description,
    this.date,
    this.heure,
    this.createdBy,
  );

  int etat;
  String createdAt;
  String id;
  String idPatient;
  String imagePatient;
  String namePatient;
  String description;
  String date;
  int heure;
  String createdBy;

  Appointment.fromJson(Map<String, dynamic> json)
      : etat = int.parse(json['etat'].toString()),
        createdAt = json['createdAt'].toString(),
        id = json['_id'].toString(),
        description = json['description'].toString(),
        date = json['date'].toString(),
        heure = int.parse(json['heure'].toString()),
        createdBy = json['createdBy'].toString(),
        idPatient = json['idPatient'].toString(),
        namePatient = json['fullnamePatient'].toString(),
        imagePatient = URLS.BASE_URL + '/' + json['imagePatient'].toString();
}
