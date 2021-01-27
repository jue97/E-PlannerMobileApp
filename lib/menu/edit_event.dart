import 'package:EPlanner/map/map2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:EPlanner/Shared/constant.dart';
import 'package:EPlanner/menu/list_event.dart';

class EditEvent extends StatefulWidget {
  /*final DocumentSnapshot data;*/
  final String eName, eDesc, eVenue, eDate, eTime;
  final index;

  EditEvent(
      {this.eName,
      this.eDesc,
      this.eVenue,
      this.eDate,
      this.eTime,
      this.index});

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  TextEditingController name = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  TextEditingController venue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController time = new TextEditingController();

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
  var _value;
  // ignore: non_constant_identifier_names
  List<DropdownMenuItem> VenueList = [];

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
        //_dateText = "${picked.day}-${picked.month}-${picked.year}";
        eventDate = "${picked.day}-${picked.month}-${picked.year}";
        date.text = _dateText;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() {
        _time = picked;
        //_timeText = "${picked.format(context)}";
        eventTime = "${picked.format(context)}";
        time.text = _timeText;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    venue = TextEditingController(text: "${widget.eVenue}");
    fetchEvntName();
    getEventData();
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
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            width: size.width,
            child: Column(
              children: <Widget>[
                Text(
                  "Edit Event",
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
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        child: TextFormField(
                          controller: name,
                          onChanged: (String str) {
                            setState(() {
                              eventName = str;
                            });
                          },
                          decoration: textInputDecoration.copyWith(
                          labelText: "${widget.eName}"
                          ),
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
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        child: TextFormField(
                          controller: desc,
                          onChanged: (String str) {
                            setState(() {
                              eventDesc = str;
                            });
                          },
                          decoration: textInputDecoration.copyWith(
                            labelText: "${widget.eName}"
                          ),
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
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Icon(FontAwesomeIcons.marker, size: 30.0, color: Colors.teal,),
                            SizedBox(width: 0.2),
                            DropdownButton(
                              items: VenueList,
                              onChanged: (venue) {
                                setState(() {
                                  _value = venue.toString();
                                  eventVenue = _value;
                                });
                              },
                              value: _value,
                              isExpanded: false,
                              hint: new Text('${widget.eVenue}'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Map2()),
                          );
                        },
                        child: Text(
                          "View Map",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ),
                      /*Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                        child: TextFormField(
                          controller: venue,
                          onChanged: (String str) {
                            setState(() {
                              eventVenue = str;
                            });
                          },
                          decoration: textInputDecoration.copyWith(),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),*/
                      //date
                      Text("Date"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        child: TextFormField(
                          controller: date,
                          decoration: textInputDecoration.copyWith(
                              hintText: (eventDate)),
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
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        child: TextFormField(
                          controller: time,
                          decoration: textInputDecoration.copyWith(
                              hintText: (eventTime)),
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
                              child: Text("Edit"),
                              onPressed: () async {
                                await _updateEvent();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListEvent()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ])),
    );
  }

  addEvent() async {
    FirebaseFirestore.instance.collection("event").add({
      'name': eventName,
      'desc': eventDesc,
      'venue': eventVenue,
      'date': eventDate,
      'time': eventTime
    });
  }

  getEventData() {
    /*name.text = widget.data["name"];
    desc.text = widget.data["description"];
    venue.text = widget.data["venue"];
    date.text = widget.data["date"];
    time.text = widget.data["time"];*/
    setState(() {
      eventName = widget.eName;
      eventDesc = widget.eDesc;
      eventVenue = widget.eVenue;
      eventDate = widget.eDate;
      eventTime = widget.eTime;

      _dateText = "${_date.day}/${_date.month}/${_date.year}";
    });
    /*print(eventName);
    print(eventDesc);
    print(eventVenue);
    print(eventDate);
    print(eventTime);*/
  }

  editEvent(uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("event");
    return await collectionReference.doc(uid).set({
      "name": name.text,
      "description": desc.text,
      "venue": _value,
      "date": date.text,
      "time": time.text,
    });
  }

  void _updateEvent() {
    print("$eventName, $eventDate, $eventVenue, $eventDesc, $eventTime");
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "date": eventDate,
        "desc": eventDesc,
        "name": eventName,
        "time": eventTime,
        "venue": eventVenue,
      });
    });
  }

  fetchEvntName() async {
    FirebaseFirestore.instance.collection("Venue").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          VenueList.add(DropdownMenuItem(
            child: Text(
              result.data()["vName"],
              style: TextStyle(color: Colors.black),
            ),
            value: result.data()["vName"],
          ));
        });
      });
    });
  }
}

/*
 void updateEvent(String name) {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      var widget;
      DocumentSnapshot snapshot = await transaction.get(widget.index);

      return transaction.update(snapshot.reference, {
        'name': name,
        //'desc': eventDesc,
        //'venue': eventVenue,
      // 'date': eventDate,
       // 'time': eventTime
      });
    });
  }*/
