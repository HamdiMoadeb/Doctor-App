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

  Doctor.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        accountState = json['accountState'],
        createdAt = json['createdAt'],
        id = json['_id'],
        fullname = json['fullname'],
        phone = json['phone'],
        email = json['email'],
        speciality = json['speciality'],
        address = json['address'],
        password = json['password'];

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
      };
}
