import 'package:doctor_app/models/assistant.dart';
import 'package:doctor_app/screens/add_assitance_page.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/components/item_assitance.dart';
import 'package:doctor_app/api_calls/api_assistant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssitancesList extends StatefulWidget {
  @override
  AssitancesListState createState() => new AssitancesListState();
}

class AssitancesListState extends State<AssitancesList> {
  List<Assistant> assistants = List<Assistant>();

  String idDoc = '';

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
        title: Text('Assistantes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAssistance(),
            ),
          );
        },
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: ApiAssistant.getAllAssistantsByDoc(idDoc),
        builder: (context, snapshot) {
          assistants = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) =>
                  ItemCardAssitance(
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
