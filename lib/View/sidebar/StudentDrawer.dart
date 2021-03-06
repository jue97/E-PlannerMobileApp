import 'package:flutter/material.dart';
import 'package:EPlanner/Controller/auth_helper.dart';
import 'package:EPlanner/menu/listEventStud.dart';
import 'package:EPlanner/menu/notification.dart';

class StudentDrawer extends StatefulWidget {
  @override
  _StudentDrawerState createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'Student',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

           ListTile(
            leading: Icon(Icons.event_note),
            title: Text('List Event'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListEventS()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notify()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () async {
              await AuthService.logOut();
            },
          ),
        ],
      ),
    );
  }
}
