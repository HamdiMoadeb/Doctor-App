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
      : etat = json['etat'],
        createdAt = json['createdAt'],
        id = json['_id'],
        description = json['description'],
        date = json['date'],
        heure = json['heure'],
        createdBy = json['createdBy'],
        idPatient = json['idPatient'],
        namePatient = json['fullnamePatient'],
        imagePatient = URLS.BASE_URL + '/' + json['imagePatient'];
}
