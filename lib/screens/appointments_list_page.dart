import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card.dart';
import 'package:doctor_app/models/appointment.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class AppointmentsList extends StatelessWidget {
  final List<Appointment> listRDVs = [
    Appointment(
        '12 Mar 2020',
        'Hamdi Moadeb',
        '28 572 243',
        '1',
        '12:30 PM',
        'Exo de dent 36',
        'https://careermetis.com/wp-content/uploads/2017/11/GC-ML-IMG_4366_009.jpg'),
    Appointment(
        '12 Mar 2020',
        'Mohamed Moadeb',
        '28 572 243',
        '3',
        '12:30 PM',
        'Exo de dent 36',
        'https://camo.githubusercontent.com/7fcd5244febadb5e77bbd18301431767902bf3bb/68747470733a2f2f692e696d6775722e636f6d2f3062794f6877512e6a7067'),
    Appointment(
        '12 Mar 2020',
        'Ayoub Ghozzi',
        '28 572 243',
        '1',
        '12:30 PM',
        'Exo de dent 36',
        'https://outpostrecruitment.com/wp-content/uploads/2019/05/Ruairi-Spillane.png'),
    Appointment(
        '12 Mar 2020',
        'Donia Azib',
        '28 572 243',
        '2',
        '12:30 PM',
        'Exo de dent 36',
        'https://data.whicdn.com/images/320234553/original.jpg'),
    Appointment(
        '12 Mar 2020',
        'Mahmoud Ghandour',
        '28 572 243',
        '3',
        '12:30 PM',
        'Exo de dent 36',
        'https://oldstyledating.co.uk/wp-content/uploads/2019/08/Headshot-photographer-Lincoln-Nottingham-Leicester-Peterborough-Midlands-Andrej-V-captivating-headshots-1080x675.jpg'),
    Appointment(
        '12 Mar 2020',
        'Bilel Kechiche',
        '28 572 243',
        '1',
        '12:30 PM',
        'Exo de dent 36',
        'https://careermetis.com/wp-content/uploads/2017/11/GC-ML-IMG_4366_009.jpg'),
    Appointment(
        '12 Mar 2020',
        'Ennaceur Ben Yedder',
        '28 572 243',
        '1',
        '12:30 PM',
        'Exo de dent 36',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjYBVd9MD-pnIIKGjJS1tdx2PiprjCtF7_X1tvNK87PE1ETh7H'),
  ];

  DateTime datePicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: DatePickerTimeline(
            DateTime.now(),
            height: 80.0,
            locale: 'fr',
            onDateChange: (date) {
              // New date selected
              print(date.toString());
            },
          ),
        ),
        Expanded(
          flex: 7,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            itemCount: listRDVs.length,
            itemBuilder: (BuildContext context, int index) => ItemCard(
              context: context,
              index: index,
              listdvs: listRDVs,
            ),
          ),
        ),
      ],
    );
  }
}
