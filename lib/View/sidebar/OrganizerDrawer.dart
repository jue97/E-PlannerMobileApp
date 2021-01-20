import 'package:flutter/material.dart';
import 'package:EPlanner/Controller/auth_helper.dart';
import 'package:EPlanner/menu/list_event.dart';
import 'package:EPlanner/menu/manage_event.dart';

class OrganizerDrawer extends StatefulWidget {
  @override
  _OrganizerDrawerState createState() => _OrganizerDrawerState();
}

class _OrganizerDrawerState extends State<OrganizerDrawer> {
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
              'Organizer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Manage Event'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageEvent()),
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
          /*ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notify()),
              );
            },
          ),*/
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
