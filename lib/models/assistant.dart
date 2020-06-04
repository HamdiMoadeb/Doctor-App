import 'package:doctor_app/api_calls/urls.dart';

class Assistant {
  Assistant(
    this.role,
    this.accountState,
    this.createdAt,
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.password,
    this.image,
    this.createdBy,
  );

  final String role;
  final bool accountState;
  final String createdAt;
  final String id;
  final String fullname;
  final String phone;
  final String email;
  final String password;
  final String image;
  final String createdBy;

  Assistant.fromJson(Map<String, dynamic> json)
      : image = URLS.BASE_URL + '/' + json['image'],
        role = json['role'],
        accountState = json['accountState'],
        createdAt = json['createdAt'],
        id = json['_id'],
        fullname = json['fullname'],
        phone = json['phone'],
        email = json['email'],
        password = json['password'],
        createdBy = json['createdBy'];

  Map<String, dynamic> toJson() => {
        'role': role,
        'accountState': accountState,
        'createdAt': createdAt,
        '_id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'password': password,
        'createdBy': createdBy,
      };
}
