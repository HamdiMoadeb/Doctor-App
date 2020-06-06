import 'package:doctor_app/api_calls/urls.dart';

class Patient {
  final String id;
  final String firstname;
  final String lastname;
  final String birthday;
  final String address;
  final String profession;
  final String gender;
  final String phone;
  final String email;
  final String photourl;

  Patient(this.id, this.firstname, this.lastname, this.birthday, this.address,
      this.profession, this.gender, this.phone, this.email, this.photourl);

  Patient.fromJson(Map<String, dynamic> json)
      : id = json['_id'].toString(),
        firstname = json['firstname'].toString(),
        lastname = json['lastname'].toString(),
        birthday = json['birthday'].toString(),
        address = json['address'].toString(),
        profession = json['profession'].toString(),
        gender = json['gender'].toString(),
        phone = json['phone'].toString(),
        email = json['email'].toString(),
        photourl = URLS.BASE_URL + '/' + json['image'].toString();
}
