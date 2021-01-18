import 'package:flutter/material.dart';
import 'package:sampleproject/Controller/auth_helper.dart';
import 'package:sampleproject/View/Profile/adminProfile.dart';
import 'package:sampleproject/map/map4.dart';
import 'package:sampleproject/menu/add_event.dart';
import 'package:sampleproject/menu/list_event.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
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
              'Admin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          /*ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminProfile()),
              );
            },
          ),*/
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Manage Event'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEvent()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text('List Event'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListEvent()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Location'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapView()),
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
