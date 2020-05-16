import 'package:flutter/material.dart';

class RadioGender extends StatefulWidget {
  RadioGender({Key key, this.callback}) : super(key: key);

  Function(String) callback;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

enum SingingCharacter { Male, Female }

class _MyStatefulWidgetState extends State<RadioGender> {
  SingingCharacter _character = SingingCharacter.Female;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Female'),
        Radio(
          value: SingingCharacter.Female,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              widget.callback(value.toString().split('.').last);
            });
          },
        ),
        Text('Male'),
        Radio(
          value: SingingCharacter.Male,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              widget.callback(value.toString().split('.').last);
            });
          },
        ),
      ],
    );
  }
}
