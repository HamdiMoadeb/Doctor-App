class Appointment {
  Appointment(
    this.date,
    this.full_name,
    this.phone,
    this.tag,
    this.time,
    this.title,
    this.photourl,
  );

  final String full_name;
  final String phone;
  final String title;
  final String tag;
  final String date;
  final String time;
  final String photourl;
}
