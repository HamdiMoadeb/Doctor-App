import 'package:doctor_app/components/item_notification.dart';
import 'package:doctor_app/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/api_calls/api_appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsList extends StatefulWidget {
  @override
  NotificationsListState createState() => new NotificationsListState();
}

class NotificationsListState extends State<NotificationsList> {
  List<Appointment> assistants = List<Appointment>();

  String idDoc = '';
  DateTime selectedDate = DateTime.now();

  callback() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<String> getDocId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('idDoc');
      setState(() {
        idDoc = token;
      });
      return token;
    }

    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
        future: ApiAppointment.getAllAppointmentsByDay({
          "date": selectedDate.toString(),
        }),
        builder: (context, snapshot) {
          assistants = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) =>
                  ItemNotification(
                context: context,
                index: index,
                listdvs: assistants,
              ),
              itemCount: assistants.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
