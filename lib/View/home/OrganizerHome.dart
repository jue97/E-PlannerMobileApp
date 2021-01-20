import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EPlanner/Shared/loading.dart';
import 'package:EPlanner/View/sidebar/OrganizerDrawer.dart';
import 'package:EPlanner/map/map4.dart';
import 'package:EPlanner/menu/add_event.dart';
import 'package:EPlanner/menu/list_event.dart';
import 'package:EPlanner/menu/notification.dart';

class OrganizerHome extends StatefulWidget {
  @override
  _OrganizerHomeState createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  User user;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
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
              title: Text("Organizer Home"),
              backgroundColor: Colors.orange,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
            ),
            drawer: OrganizerDrawer(),
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
                                  builder: (context) => MapView()),
                            );
                          },
                          splashColor: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          );
  }
}
