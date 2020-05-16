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
      : id = json['_id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birthday = json['birthday'],
        address = json['address'],
        profession = json['profession'],
        gender = json['gender'],
        phone = json['phone'],
        email = json['email'],
        photourl =
            'https://outpostrecruitment.com/wp-content/uploads/2019/05/Ruairi-Spillane.png';
}
