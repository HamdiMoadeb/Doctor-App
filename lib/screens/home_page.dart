import 'package:flutter/material.dart';
import 'appointments_list_page.dart';
import 'patients_list_page.dart';
import 'add_appointment_page.dart';
import 'add_patient_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text(setTitle()),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: null,
          ),
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
