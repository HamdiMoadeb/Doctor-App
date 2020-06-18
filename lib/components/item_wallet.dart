import 'package:doctor_app/api_calls/api_wallet.dart';
import 'package:doctor_app/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemWallet extends StatefulWidget {
  ItemWallet(
      {@required this.context,
      @required this.index,
      @required this.listdvs,
      @required this.callback});

  final BuildContext context;
  final int index;
  final List<Wallet> listdvs;
  Function() callback;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(
      context: context, index: index, listdvs: listdvs, callback: callback);
}

class _MyStatefulWidgetState extends State<ItemWallet> {
  _MyStatefulWidgetState(
      {@required this.context,
      @required this.index,
      @required this.listdvs,
      @required this.callback});

  final BuildContext context;
  final int index;
  final List<Wallet> listdvs;
  Function() callback;

  displayDialogActivation(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure to delete this amount ?'),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    ApiWallet.deleteWallet(id).then((onValue) {
                      Navigator.pop(context);
                      widget.callback();
                    });
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double cwidth = MediaQuery.of(context).size.width * 0.6;
    double cwidthText = MediaQuery.of(context).size.width * 0.7;
    Wallet wallet = listdvs[index];
    DateTime dateTime = DateTime.parse(wallet.date);
    String dateRDV = new DateFormat.yMd('fr_FR').format(dateTime).toString();
    print(dateRDV);
    return Container(
      child: InkWell(
        onTap: () => displayDialogActivation(context, wallet.id),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: cwidthText,
                          child: Text(
                            wallet.fullnamePatient,
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
                          height: 3.0,
                        ),
                        Container(
                          width: cwidthText,
                          child: Text(
                            wallet.description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              // backgroundColor: Color(0x29ED34E3),
                              fontSize: 15.0,
                              color: Colors.grey.shade500,
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
                                color: Colors.green,
                                size: 17.0,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                dateRDV,
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
                    Spacer(),
                    Container(
                      child: Text(
                        '${wallet.amount} \n DT',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // backgroundColor: Color(0x29ED34E3),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
