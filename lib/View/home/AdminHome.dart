import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Shared/loading.dart';
import 'package:sampleproject/View/sidebar/AdminDrawer.dart';
import 'package:sampleproject/map/map2.dart';
import 'package:sampleproject/menu/add_event.dart';
import 'package:sampleproject/menu/list_event.dart';
import 'package:sampleproject/menu/notification.dart';

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
              title: Text("Admin Home"),
              backgroundColor: Colors.orange,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
            ),
            drawer: AdminDrawer(),
            body: Center(
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
                          child: new Text("Manage Event"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEvent()),
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
                          child: new Text("List Event"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListEvent()),
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
                          child: new Text("Location"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Map2()),
                            );
                          },
                          splashColor: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}
