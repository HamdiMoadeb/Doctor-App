import 'package:doctor_app/api_calls/api_wallet.dart';
import 'package:doctor_app/components/item_wallet.dart';
import 'package:doctor_app/models/wallet.dart';
import 'package:doctor_app/screens/add_wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor_app/models/patient.dart';

class WalletPatientPage extends StatefulWidget {
  WalletPatientPage({@required this.patient});

  final Patient patient;

  @override
  WalletPageState createState() => new WalletPageState(patient: patient);
}

class WalletPageState extends State<WalletPatientPage> {
  WalletPageState({@required this.patient});

  final Patient patient;

  List<Wallet> wallets = List<Wallet>();
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
        title: Text('Paiements'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWallet(
                patient: patient,
              ),
            ),
          );
        },
        child: Icon(
          Icons.attach_money,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: ApiWallet.getAllWalletByPatient(patient.id),
        builder: (context, snapshot) {
          wallets = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => ItemWallet(
                context: context,
                index: index,
                listdvs: wallets,
                callback: callback,
              ),
              itemCount: wallets.length,
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
