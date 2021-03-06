import 'package:doctor_app/api_calls/api_appointment.dart';
import 'package:doctor_app/api_calls/api_notification.dart';
import 'package:doctor_app/api_calls/api_patient.dart';
import 'package:doctor_app/models/notification.dart';
import 'package:doctor_app/screens/reschedule_appointment_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/appointment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class NotificationDetails extends StatefulWidget {
  NotificationDetails({
    @required this.notification,
  });

  final NotificationR notification;

  @override
  NotificationDetailsState createState() =>
      new NotificationDetailsState(notification: notification);
}

class NotificationDetailsState extends State<NotificationDetails> {
  NotificationDetailsState({
    @required this.notification,
  });

  var descController = TextEditingController();
  NotificationR notification;

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
          fontSize: 17.0,
          color: textColor,
        ),
      ),
    );
  }

  String daysIndication(DateTime dateTime) {
    final date2 = DateTime.now();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (aDate == today) {
      return 'Today';
    } else if (dateTime.isBefore(date2)) {
      final difference = date2.difference(dateTime).inDays;
      if (difference == 0) {
        return 'Yesterday';
      } else {
        return '$difference days ago';
      }
    } else if (dateTime.isAfter(date2)) {
      final difference = dateTime.difference(date2).inDays;
      var diff = difference + 1;
      if (diff == 1) {
        return 'Tomorrow';
      } else {
        return 'in $diff days';
      }
    }
  }

   _displayDialogCancel(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cancel Request'),
            content: Text('Are you sure to cancel this request ?'),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    ApiNotification.cancelNotification(notification.id)
                        .then((onValue) {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  })
            ],
          );
        });
  }

  _displayDialogValidate(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validate Request'),
            content: Text('Are you sure to validate this request ?'),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    ApiNotification.validateNotification(notification.id)
                        .then((onValue) {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  })
            ],
          );
        });
  }

  String email = '...';
  String phone = '...';
  int etat;
  bool visiblityReschdule;
  bool visiblityFinish;
  bool visiblityCancel;
  bool visiblityNewDate;
  bool visiblityOldDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etat = notification.etat;
    if (etat == 0) {
      visiblityReschdule = false;
      visiblityFinish = false;
      visiblityCancel = false;
      visiblityNewDate = false;
      visiblityOldDate = true;

      ApiNotification.cancelNotification(notification.id);

    } else if (etat == 1) {
      visiblityReschdule = false;
      visiblityFinish = true;
      visiblityCancel = true;
      visiblityNewDate = true;
      visiblityOldDate = false;
    }
    ApiPatient.getPatientById(notification.createdBy).then((onValue) {
      setState(() {
        email = onValue.email;
        phone = onValue.phone;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime oldDateTime = DateTime.parse(notification.olddate);
    DateTime newDateTime = DateTime.parse(notification.newdate);
    String OLDdate = new DateFormat.yMd('fr_FR').format(oldDateTime).toString();
    String NEWdate = new DateFormat.yMd('fr_FR').format(newDateTime).toString();
    double cwidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[tagLabel(notification.etat)],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                CircleAvatar(
                  radius: 38.0,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 36.0,
                    backgroundImage: NetworkImage(notification.imagePatient),
                  ),
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
                      width: 250.0,
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
                    Container(
                      width: 250.0,
                      child: Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 15.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      child: Text(
                        'Patient phone',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 15.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      width: 250.0,
                      child: Text(
                        phone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () => launch("tel://" + phone),
                  child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 250.0,
                      child: Text(
                        'Description RDV',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 15.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      width: cwidth,
                      child: Text(
                        notification.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 16.0,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Visibility(
                      visible: true,
                      child:  Container(
                        width: 250.0,
                        child: Text(
                          'Date and Time',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 3.0,
                    ),
                    Visibility(
                      visible: true,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.today,
                            color: Colors.black,
                            size: 23.0,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            OLDdate,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Icon(
                            Icons.access_time,
                            color: Colors.black,
                            size: 23.0,
                          ),
                          Text(
                            getHour(notification.oldheure),
                            style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                    SizedBox(
                      height: 3.0,
                    ),
                    Visibility(
                      visible: visiblityNewDate,
                      child: Container(
                        width: 250.0,
                        child: Text(
                          'New Date and Time',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Visibility(
                      visible: visiblityNewDate,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.today,
                            color: Colors.black,
                            size: 23.0,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            NEWdate,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Icon(
                            Icons.access_time,
                            color: Colors.yellow.shade700,
                            size: 23.0,
                          ),
                          Text(
                            getHour(notification.newheure),
                            style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Visibility(
                  visible: false,
                  child: RaisedButton(
                    color: Colors.yellow.shade700,
                    onPressed: () {},
                    child: const Text(
                      'Reschdule',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Visibility(
                  visible: visiblityFinish,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () => _displayDialogValidate(context),
                    child: const Text(
                      'Accept',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Visibility(
                  visible: visiblityCancel,
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () => _displayDialogCancel(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
