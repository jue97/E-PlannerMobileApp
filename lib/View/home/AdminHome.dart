import 'package:EPlanner/map/map4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EPlanner/Shared/loading.dart';
import 'package:EPlanner/View/sidebar/AdminDrawer.dart';
import 'package:EPlanner/menu/add_event.dart';
import 'package:EPlanner/menu/list_event.dart';
import 'package:EPlanner/menu/notification.dart';

class AdminHome extends StatefulWidget {
  final String uid;
  AdminHome({this.uid});

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  User user;
  bool loading = false;

  /*int _currentIndex = 0;
  final List<Widget> _children = [
    ManageEvent(),
    ListEvent(),
    MapsPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 20.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Notify()));
                    })
              ],
              title: Text(
                "ADMIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              backgroundColor: Colors.orange,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
            ),
            drawer: AdminDrawer(),
            body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                    child: Container(
                        width: size.width,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "WELCOME TO E-PLANNER",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: new MaterialButton(
                                        height: 100,
                                        minWidth: 300,
                                        color: Colors.orangeAccent[100],
                                        textColor: Colors.black,
                                        child: new Text(
                                          "Manage Event",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddEvent()),
                                          );
                                        },
                                        splashColor: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: new MaterialButton(
                                        height: 100,
                                        minWidth: 300,
                                        color: Colors.orangeAccent[100],
                                        textColor: Colors.black,
                                        child: new Text(
                                          "List Event",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListEvent()),
                                          );
                                        },
                                        splashColor: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: new MaterialButton(
                                        height: 100,
                                        minWidth: 300,
                                        color: Colors.orangeAccent[100],
                                        textColor: Colors.black,
                                        child: new Text(
                                          "Location",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MapView()),
                                          );
                                        },
                                        splashColor: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ])))));
  }
}
