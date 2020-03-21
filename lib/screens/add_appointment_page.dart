import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/components/searchable_dropdown.dart';

class AddAppointment extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AddAppointment> {
  bool isSelected = false;
  var data = ['Small', 'Medium', 'Large', 'XLarge'];
  int _value = 1;
  bool status = false;
  DateTime selectedDate = DateTime.now();

  List<ChipData> chipsData = [
    //Matin
    ChipData(' 8:00 AM', false, true, 0),
    ChipData('8:30 AM', false, true, 0),
    ChipData('9:00 AM', false, false, 0),
    ChipData('9:30 AM', false, true, 0),
    ChipData('10:00 AM', false, true, 0),
    ChipData('10:30 AM', false, false, 0),
    ChipData('11:00 AM', false, true, 0),
    ChipData('11:30 AM', false, true, 0),
    //Midi
    ChipData('12:00 PM', false, true, 1),
    ChipData('12:30 PM', false, true, 1),
    ChipData('1:00 PM', false, false, 1),
    ChipData('1:30 PM', false, true, 1),
    ChipData('2:00 PM', false, true, 1),
    ChipData('2:30 PM', false, false, 1),
    ChipData('3:00 PM', false, true, 1),
    ChipData('3:30 PM', false, true, 1),
    //Soir
    ChipData('4:00 PM', false, true, 2),
    ChipData('4:30 PM', false, true, 2),
    ChipData('5:00 PM', false, false, 2),
    ChipData('5:30 PM', false, true, 2),
    ChipData('6:00 PM', false, true, 2),
    ChipData('6:30 PM', false, false, 2),
    ChipData('7:00 PM', false, true, 2),
    ChipData('7:30 PM', false, true, 2),
  ];

  int getChipClicked(String time) {
    for (var i = 0; i < chipsData.length; i++) {
      if (chipsData[i].time == time) {
        print('clicked : $i');
        return i;
      } else {
        chipsData[i].selected = false;
      }
    }
  }

  void setChipNotSelected(int index) {
    for (var i = 0; i < chipsData.length; i++) {
      if (i != index) {
        chipsData[i].selected = false;
      }
    }
  }

  RawChip getChip(int chipindex, int rowNb) {
    ChipData chipData;
    if (rowNb == 0) {
      chipData = chipsData[chipindex];
    } else if (rowNb == 1) {
      chipData = chipsData[chipindex + 8];
    } else {
      chipData = chipsData[chipindex + 16];
    }
    return RawChip(
      label: Text(
        chipData.time,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      backgroundColor: Colors.grey.shade500,
      selected: chipData.selected,
      checkmarkColor: Colors.black45,
      isEnabled: chipData.enabled,
      disabledColor: Colors.red.shade100,
      selectedColor: Colors.blue,
      onSelected: (bool isSelected) {
        setState(() {
          int index = getChipClicked(chipData.time);
          if (index != null) {
            if (chipsData[index].selected == true) {
              chipsData[index].selected = false;
            } else {
              setChipNotSelected(index);
              chipsData[index].selected = true;
            }
          }
        });
      },
      showCheckmark: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un RDV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SearchableDrop(),
            ),
            Expanded(
              flex: 1,
              child: DatePickerTimeline(
                selectedDate,
                height: 80.0,
                locale: 'fr',
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                  print(date.toString());
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  return new ExpansionTile(
                    title: Row(
                      children: <Widget>[
                        Text(
                          vehicles[i].title,
                          style: new TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          vehicles[i].time,
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              getChip(0, i),
                              getChip(1, i),
                              getChip(2, i),
                              getChip(3, i),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              getChip(4, i),
                              getChip(5, i),
                              getChip(6, i),
                              getChip(7, i),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  width: 200.0,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue,
                    child: Text(
                      'Ajouter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        Text(
          content,
          style: TextStyle(fontSize: 18.0),
        ),
      );

    return columnContent;
  }
}

/*class AddAppointment extends StatelessWidget {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un RDV'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: InputChip(
                  label: Text('Place'),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.red,
                  onSelected: (bool value) {
                    setState(() {
                      isSelected = value;
                    });
                  },
                  deleteIcon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onDeleted: () {
                    print('delete');
                  },
                  selected: isSelected,
                  selectedColor: Colors.green,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, i) {
                return new ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        vehicles[i].title,
                        style: new TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vehicles[i].time,
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    new Column(
                      children: _buildExpandableContent(vehicles[i]),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}*/

class ChipData {
  String time;
  bool selected;
  bool enabled;
  int idx;

  ChipData(this.time, this.selected, this.enabled, this.idx);
}

class Vehicle {
  final String title;
  final String time;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.time, this.contents, this.icon);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'Matin  ',
    '8 AM - 12 PM',
    ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
    Icons.motorcycle,
  ),
  new Vehicle(
    'Après Midi  ',
    '12 PM - 4 PM',
    ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
    Icons.directions_car,
  ),
  new Vehicle(
    'Soir  ',
    '4 PM - 8 PM',
    ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
    Icons.directions_car,
  ),
];
