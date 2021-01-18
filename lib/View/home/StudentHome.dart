import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Shared/loading.dart';
import 'package:sampleproject/View/sidebar/StudentDrawer.dart';
import 'package:sampleproject/menu/listEventStud.dart';


class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
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
                IconButton(icon: Icon(Icons.search), onPressed: null)
              ],
              title: Text("Student Home"),
              backgroundColor: Colors.orange,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              elevation: 0.0,
            ),
            drawer: StudentDrawer(),
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
                          child: new Text("List Event"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListEventS()),
                            );
                          },
                          splashColor: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                ])));
  }
}
