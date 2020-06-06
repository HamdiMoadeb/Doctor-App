import 'package:doctor_app/api_calls/urls.dart';

class Doctor {
  Doctor(
    this.role,
    this.accountState,
    this.createdAt,
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.speciality,
    this.address,
    this.password,
    this.image,
  );

  final String role;
  final bool accountState;
  final String createdAt;
  final String id;
  final String fullname;
  final String phone;
  final String email;
  final String speciality;
  final String address;
  final String password;
  final String image;

  Doctor.fromJson(Map<String, dynamic> json)
      : image = URLS.BASE_URL + '/' + json['image'].toString(),
        role = json['role'].toString(),
        accountState = bool.fromEnvironment(json['accountState'].toString()),
        createdAt = json['createdAt'].toString(),
        id = json['_id'].toString(),
        fullname = json['fullname'].toString(),
        phone = json['phone'].toString(),
        email = json['email'].toString(),
        speciality = json['speciality'].toString(),
        address = json['address'].toString(),
        password = json['password'].toString();
/*
  Map<String, dynamic> toJson() => {
        'role': role,
        'accountState': accountState,
        'createdAt': createdAt,
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'speciality': speciality,
        'address': address,
        'password': password,
      };*/
}
