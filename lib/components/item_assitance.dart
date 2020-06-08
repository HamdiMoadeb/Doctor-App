import 'package:doctor_app/models/assistant.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/api_calls/api_assistant.dart';

class ItemCardAssitance extends StatefulWidget {
  ItemCardAssitance(
      {@required this.context,
      @required this.index,
      @required this.listdvs,
      @required this.callback});

  final BuildContext context;
  final int index;
  final List<Assistant> listdvs;
  Function() callback;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(
      context: context, index: index, listdvs: listdvs, callback: callback);
}

class _MyStatefulWidgetState extends State<ItemCardAssitance> {
  _MyStatefulWidgetState(
      {@required this.context,
      @required this.index,
      @required this.listdvs,
      @required this.callback});

  final BuildContext context;
  final int index;
  final List<Assistant> listdvs;
  Function() callback;

  String stateT = '';

  displayDialogActivation(BuildContext context, bool state, String id) async {
    String activation = '';
    if (state) {
      activation = 'deactivate';
    } else {
      activation = 'activate';
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Activation'),
            content: Text('Are you sure to $activation this account ?'),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    ApiAssistant.activateAssistant(id).then((onValue) {
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
    Assistant assistant = listdvs[index];
    if (listdvs[index].accountState) {
      stateT = 'Active';
    } else {
      stateT = 'Inactive';
    }
    return Container(
      child: Card(
        child: InkWell(
          onTap: () => displayDialogActivation(
              context, assistant.accountState, assistant.id),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(assistant.image),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          assistant.fullname,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          assistant.email,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            // backgroundColor: Color(0x29ED34E3),
                            fontSize: 15.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 18.0,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      assistant.phone,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.green,
                      ),
                    ),
                    Spacer(),
                    Text(
                      stateT,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    /*CircleAvatar(
                      radius: 18.0,
                      backgroundImage: AssetImage('images/phoneicon.png'),
                    ),*/
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
