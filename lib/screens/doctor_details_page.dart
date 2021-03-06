import 'dart:io';
import 'package:doctor_app/api_calls/api_auth.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:doctor_app/api_calls/urls.dart';
import 'package:http_parser/http_parser.dart';

class DoctorDetails extends StatefulWidget {
  @override
  DoctorDetailsState createState() => new DoctorDetailsState();
}

class DoctorDetailsState extends State<DoctorDetails> {
  String docId = '';
  String docName = '';
  String docSpeciality = '';
  String docPhone = '';
  String docEmail = '';
  String docAdress = '';
  String docImage = '';
  TextEditingController _textFieldController = TextEditingController();
  final picker = ImagePicker();
  File _image;

  Future<String> setDocInfo(String value, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (type == 'phone') {
      await prefs.setString('phoneDoc', value);
      setState(() {
        docPhone = value;
      });
    } else if (type == 'email') {
      await prefs.setString('emailDoc', value);
      setState(() {
        docEmail = value;
      });
    } else if (type == 'address') {
      await prefs.setString('adreslDoc', value);
      setState(() {
        docAdress = value;
      });
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.camera_alt),
                title: new Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
              new ListTile(
                  leading: new Icon(Icons.photo_album),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  }),
            ]),
          );
        });
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
      imageQuality: 50,
    );

    String filename = pickedFile.path.split('/').last;
    String ext = pickedFile.path.split('.').last;
    final FormData formdata = FormData.fromMap({
      'image': await MultipartFile.fromFile(pickedFile.path, filename: filename, contentType: MediaType('image', '$ext')),
      'type':'image/$ext'
    });
    print('//////////////$filename');
    ApiAuth.uploadPhoto(formdata, docId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imageDoc','${URLS.BASE_URL}/$docId.jpg');
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  displayDialog(BuildContext context, String type, String oldvalue) async {
    _textFieldController.text = oldvalue;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit $type'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: '$type'),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('EDIT'),
                  onPressed: () {
                    final body = {
                      type: _textFieldController.text.toString(),
                    };
                    ApiAuth.editProfileDoc(body, docId).then((success) {
                      setDocInfo(_textFieldController.text.toString(), type);
                      Navigator.pop(context);
                    });
                  })
            ],
          );
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
        docPhone = prefs.getString('phoneDoc');
        docEmail = prefs.getString('emailDoc');
        docAdress = prefs.getString('adreslDoc');
        docImage = prefs.getString('imageDoc');
      });
      return 'done';
    }

    getDocInfo();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Personal information'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: InkWell(
                    onTap: () => _settingModalBottomSheet(context),
                    child: CircleAvatar(
                      radius: 52.0,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: _image == null
                            ? NetworkImage(docImage)
                            : FileImage(_image),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Dr. $docName',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  docSpeciality,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        onTap: () => displayDialog(context, 'phone', docPhone),
                        leading: Icon(
                          OMIcons.phone,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          docPhone,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          OMIcons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      ListTile(
                        onTap: () => displayDialog(context, 'email', docEmail),
                        leading: Icon(
                          OMIcons.email,
                          //Icons.check_box,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          docEmail,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          OMIcons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      ListTile(
                        onTap: () =>
                            displayDialog(context, 'address', docAdress),
                        leading: Icon(
                          OMIcons.home,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          docAdress,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          OMIcons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      /* ListTile(
                        onTap: () => displayDialog(context, 'birthday', ''),
                        leading: Icon(
                          OMIcons.calendarToday,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          '01/01/1900',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          OMIcons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),*/
                      ListTile(
                        onTap: () => displayDialog(context, 'password', ''),
                        leading: Icon(
                          OMIcons.lock,
                          //Icons.perm_contact_calendar,
                          color: Colors.blue,
                          size: 25.0,
                        ),
                        title: Text(
                          '••••••••••••',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                        trailing: Icon(
                          OMIcons.edit,
                          color: Colors.grey,
                          size: 25.0,
                        ),
                      ),
                      ListTile(),
                    ],
                  ).toList()),
            ),
          )
        ],
      ),
    );
  }
}
