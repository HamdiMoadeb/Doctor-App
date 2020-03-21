import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_card_patient.dart';
import 'package:doctor_app/models/patient.dart';

class PatientsList extends StatelessWidget {
  final List<Patient> listPatientss = [
    Patient(
      '12 Mar 2020',
      'Hamdi Moadeb',
      '28 572 243',
      '1',
      'https://careermetis.com/wp-content/uploads/2017/11/GC-ML-IMG_4366_009.jpg',
      'hamdimoadeb@gmail.com',
    ),
    Patient(
      '12 Mar 2020',
      'Mohamed Moadeb',
      '28 572 243',
      '3',
      'https://camo.githubusercontent.com/7fcd5244febadb5e77bbd18301431767902bf3bb/68747470733a2f2f692e696d6775722e636f6d2f3062794f6877512e6a7067',
      'hamdimoadeb@gmail.com',
    ),
    Patient(
      '12 Mar 2020',
      'Ayoub Ghozzi',
      '28 572 243',
      '1',
      'https://outpostrecruitment.com/wp-content/uploads/2019/05/Ruairi-Spillane.png',
      'hamdimoadeb@gmail.com',
    ),
    Patient(
        '12 Mar 2020',
        'Donia Azib',
        '28 572 243',
        '2',
        'https://data.whicdn.com/images/320234553/original.jpg',
        'hamdimoadeb@gmail.com'),
    Patient(
      '12 Mar 2020',
      'Mahmoud Ghandour',
      '28 572 243',
      '3',
      'https://oldstyledating.co.uk/wp-content/uploads/2019/08/Headshot-photographer-Lincoln-Nottingham-Leicester-Peterborough-Midlands-Andrej-V-captivating-headshots-1080x675.jpg',
      'hamdimoadeb@gmail.com',
    ),
    Patient(
      '12 Mar 2020',
      'Bilel Kechiche',
      '28 572 243',
      '1',
      'https://careermetis.com/wp-content/uploads/2017/11/GC-ML-IMG_4366_009.jpg',
      'hamdimoadeb@gmail.com',
    ),
    Patient(
      '12 Mar 2020',
      'Ennaceur Ben Yedder',
      '28 572 243',
      '1',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjYBVd9MD-pnIIKGjJS1tdx2PiprjCtF7_X1tvNK87PE1ETh7H',
      'hamdimoadeb@gmail.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: listPatientss.length,
            itemBuilder: (BuildContext context, int index) => ItemCardPatient(
              context: context,
              index: index,
              listdvs: listPatientss,
            ),
          ),
        ),
      ],
    );
  }
}
