import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Shared/constant.dart';
import 'package:sampleproject/map/map2.dart';
import 'package:sampleproject/menu/DisplayData.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController name = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  TextEditingController venue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController time = new TextEditingController();
  TextEditingController map = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String eventName = '',
      eventDesc = '',
      eventVenue = '',
      eventDate = '',
      eventTime = '';
  String error = '';
  bool loading = false;
  DateTime _date = DateTime.now();
  String title = 'Date Picker';
  String _dateText = '';
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  String _timeText = '';

  Future<Null> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        _dateText = "${picked.day}-${picked.month}-${picked.year}";
        date.text = _dateText;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() {
        _time = picked;
        _timeText = "${picked.format(context)}";
        time.text = _timeText;
      });
    }
  }

  Future<bool> submitDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Successfully Added!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }


  @override
  void initState() {
    super.initState();
    _dateText = "${_date.day}/${_date.month}/${_date.year}";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Form(
              key: _formKey,
              child: Container(
                  width: size.width,
                  child: Column(children: <Widget>[
                    Text(
                      "Add Event",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white10,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 3,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //event name
                          Text("Event Name"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: TextFormField(
                              controller: name,
                              decoration: textInputDecoration.copyWith(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          //description
                          Text("Description of Event"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: TextFormField(
                              controller: desc,
                              decoration: textInputDecoration.copyWith(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          //venue
                          Text("Venue"),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1),
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: venue,
                                    decoration: textInputDecoration.copyWith(),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 2),
                                  RaisedButton(
                                    color: Colors.orange,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Map2()),
                                      );
                                    },
                                    child: Text(
                                      "View Map",
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //date
                          Text("Date"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: TextFormField(
                              controller: date,
                              decoration: textInputDecoration.copyWith(
                                  hintText: (_dateText.toString())),
                              onTap: () {
                                setState(() {
                                  _selectDate(context);
                                });
                              },
                            ),
                          ),
                          //time
                          Text("Time"),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: TextFormField(
                              controller: time,
                              decoration: textInputDecoration.copyWith(
                                  hintText: (_timeText.toString())),
                              onTap: () {
                                setState(() {
                                  selectTime(context);
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.orangeAccent,
                                  child: Text("Submit"),
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState.validate()) {
                                        eventName = name.text;
                                        eventDesc = desc.text;
                                        eventVenue = venue.text;
                                        eventDate = date.text;
                                        eventTime = time.text;
                                      }
                                    });
                                    addEvent();
                                  },
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                      color: Colors.white,
                                      child: Text("Display Data"),
                                      onPressed: () {
                                        if (eventName != null &&
                                            eventDesc != null &&
                                            eventVenue != null &&
                                            eventDate != null &&
                                            eventTime != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DisplayData(
                                                        name: eventName,
                                                        desc: eventDesc,
                                                        venue: eventVenue,
                                                        date: eventDate,
                                                        time: eventTime,
                                                      )));
                                        }
                                      })),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])))
        ])));
  }
  addEvent() async {
    FirebaseFirestore.instance.collection("event").add({
      'name': eventName,
      'desc': eventDesc,
      'venue': eventVenue,
      'date': eventDate,
      'time': eventTime,
    });
  }
}
