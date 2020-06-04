import 'dart:ui';
import 'package:doctor_app/screens/assistants_list_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'appointments_list_page.dart';
import 'patients_list_page.dart';
import 'add_appointment_page.dart';
import 'add_patient_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doctor_details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int selectedIndex = 0;
  IconData iconData = Icons.library_add;

  final List<Widget> _children = [
    AppointmentsList(),
    PatientsList(),
  ];

  String setTitle() {
    return selectedIndex == 0 ? 'Mes Rendez-vous' : 'Patients';
  }

  String docId = '';
  String docName = '';
  String docSpeciality = '';
  String docImage = '';

  @override
  Widget build(BuildContext context) {
    Future<String> getDocInfo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        docId = prefs.getString('idDoc');
        docName = prefs.getString('nameDoc');
        docSpeciality = prefs.getString('specDoc');
        docImage = prefs.getString('imageDoc');
      });

      return 'done';
    }

    getDocInfo();
    double cwidth = MediaQuery.of(context).size.width * 0.5;
    return Container(
      color: Colors.grey.shade100,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(setTitle()),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  width: cwidth,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(docImage),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Dr. $docName',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                docSpeciality,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  // backgroundColor: Color(0x29ED34E3),
                                  fontSize: 15.0,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage('images/phoneicon.png'),
                        ),*/
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.dstATop),
                        image: AssetImage("images/health.jpg"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetails(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Sous Admin'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssitancesList(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications_active,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Notification'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Wallet'),
                onTap: () {},
              ),
              Divider(
                height: 1.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Logout'),
                onTap: () {
                  if (Navigator.canPop(context)) {
                    var count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  } else {
                    SystemNavigator.pop();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          child: _children[selectedIndex],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAppointment(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPatient(),
                ),
              );
            }
          },
          tooltip: 'Increment',
          child: Icon(iconData),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade100,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.grey.shade100,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
                iconData = index == 0 ? Icons.library_add : Icons.person_add;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.date_range,
                ),
                title: Text(
                  'Mes RDVs',
                ),
              ),
              /* BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Accueil',
                style: TextStyle(color: Colors.blue),
              ),
            ),*/
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                ),
                title: Text(
                  'Patients',
                ),
              ),
              /*BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: Colors.blue,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.blue),
              ),
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}
