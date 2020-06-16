import 'dart:ui';
import 'package:doctor_app/screens/assistants_list_page.dart';
import 'package:doctor_app/screens/notifications_page.dart';
import 'package:doctor_app/screens/wallet_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'appointments_list_page.dart';
import 'patients_list_page.dart';
import 'add_appointment_page.dart';
import 'add_patient_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doctor_details_page.dart';
import 'package:doctor_app/api_calls/api_notification.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  static int selectedIndex = 0;
  IconData iconData = Icons.library_add;
  static DateTime selectedDate = DateTime.now();
  ValueChanged<DateTime> selectDate;

  static final List<Widget> _children = [
    AppointmentsList(selectedDate: selectedDate),
    PatientsList(),
  ];

  String setTitle() {
    return selectedIndex == 0 ? 'Mes Rendez-vous' : 'Patients';
  }

  String docId = '';
  String docName = '';
  String docSpeciality = '';
  String docImage = '';
  Widget widgetSelected = _children[selectedIndex];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2100, 8));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }

  String nbNotif = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiNotification.getNbNotification().then((onValue) {
      setState(() {
        nbNotif = onValue;
      });
    });
  }

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
            Container(
              padding: const EdgeInsets.only(top: 6.0),
              child: IconButton(
                icon: Icon(
                  Icons.today,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsList(),
                  ),
                );
              },
              child: Container(
                width: 55.0,
                padding: const EdgeInsets.only(right: 10.0, top: 6.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 28.0,
                        ),
                        //Text(text, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          nbNotif,
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                        image: AssetImage('images/health.jpg'),
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
                title: Text('Assistants'),
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
                leading: Stack(children: <Widget>[
                  new Icon(
                    Icons.notifications,
                    color: Colors.blue,
                    size: 25.0,
                  ),
                  new Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: new Icon(Icons.brightness_1,
                        size: 12.0, color: Colors.redAccent),
                  )
                ]),
                /*Icon(
                  Icons.notifications_active,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),*/
                title: Text('Notification'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsList(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  //Icons.check_box,
                  color: Colors.blue,
                  size: 25.0,
                ),
                title: Text('Wallet'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WalletPage(),
                    ),
                  );
                },
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
