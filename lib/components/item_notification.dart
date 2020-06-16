import 'package:flutter/material.dart';
import 'package:doctor_app/models/notification.dart';
import 'package:intl/intl.dart';
import 'package:doctor_app/screens/notification_details_page.dart';

class ItemNotification extends StatelessWidget {
  ItemNotification({
    @required this.context,
    @required this.index,
    @required this.listdvs,
  });

  final BuildContext context;
  final int index;
  final List<NotificationR> listdvs;

  String getHour(int index) {
    switch (index) {
      case 0:
        return '8:00 AM';
      case 1:
        return '8:30 AM';
      case 2:
        return '9:00 AM';
      case 3:
        return '9:30 AM';
      case 4:
        return '10:00 AM';
      case 5:
        return '10:30 AM';
      case 6:
        return '11:00 AM';
      case 7:
        return '11:30 AM';
      case 8:
        return '12:00 PM';
      case 9:
        return '12:30 PM';
      case 10:
        return '1:00 PM';
      case 11:
        return '1:30 PM';
      case 12:
        return '2:00 PM';
      case 13:
        return '2:30 PM';
      case 14:
        return '3:00 PM';
      case 15:
        return '3:30 PM';
      case 16:
        return '4:00 PM';
      case 17:
        return '4:30 PM';
      case 18:
        return '5:00 PM';
      case 19:
        return '5:30 PM';
      case 20:
        return '6:00 PM';
      case 21:
        return '6:30 PM';
      case 22:
        return '7:00 PM';
      case 23:
        return '7:30 PM';
    }
  }

  Container tagLabel(int tagId) {
    String label;
    Color textColor;
    Color bgColor;
    if (tagId == 1) {
      label = 'REQUEST RESCHEDULE';
      textColor = Colors.orange;
      bgColor = Colors.yellow.shade500;
    } else if (tagId == 0) {
      label = 'APPOINTMENT CANCELLED';
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
    double cwidth = MediaQuery.of(context).size.width * 0.6;
    NotificationR notification = listdvs[index];
    DateTime dateTime = DateTime.parse(notification.olddate);
    String dateRDV = new DateFormat.yMd('fr_FR').format(dateTime).toString();
    print(dateRDV);
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationDetails(
                notification: notification,
              ),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(notification.imagePatient),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: cwidth,
                          child: Text(
                            notification.fullnamePatient,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: cwidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.today,
                                color: Colors.grey.shade400,
                                size: 17.0,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                dateRDV,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.access_time,
                                color: Colors.green,
                                size: 17.0,
                              ),
                              Text(
                                getHour(notification.oldheure),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              new Spacer(),
                            ],
                          ),
                        )
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
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    tagLabel(
                      notification.etat,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
