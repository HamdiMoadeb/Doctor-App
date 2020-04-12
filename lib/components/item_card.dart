import 'package:flutter/material.dart';
import 'package:doctor_app/models/appointment.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    @required this.context,
    @required this.index,
    @required this.listdvs,
  });

  final BuildContext context;
  final int index;
  final List<Appointment> listdvs;

  Container tagLabel(int tagId) {
    String label;
    Color textColor;
    Color bgColor;
    if (tagId == 1) {
      label = 'ACTIVE';
      textColor = Colors.green;
      bgColor = Colors.green.shade100;
    } else if (tagId == 2) {
      label = 'RESCHEDULED';
      textColor = Colors.orange;
      bgColor = Colors.yellowAccent.shade100;
    } else if (tagId == 3) {
      label = 'CANCELLED';
      textColor = Colors.red;
      bgColor = Colors.red.shade100;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
      color: bgColor,
      child: Text(
        label,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 15.0,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Appointment appointment = listdvs[index];
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(appointment.photourl),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        appointment.full_name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appointment.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 18.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  new Spacer(),
                  /*CircleAvatar(
                    radius: 15.0,
                    backgroundImage: AssetImage('images/phoneicon.png'),
                  ),*/
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.today,
                    color: Colors.grey.shade400,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    appointment.date,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.access_time,
                    color: Colors.grey.shade400,
                    size: 18.0,
                  ),
                  Text(
                    appointment.time,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  new Spacer(),
                  tagLabel(
                    int.parse(appointment.tag),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
