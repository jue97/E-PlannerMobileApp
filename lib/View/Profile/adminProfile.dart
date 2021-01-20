import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EPlanner/Controller/UserDBHandler.dart';
import 'package:EPlanner/View/home/AdminHome.dart';

import 'package:EPlanner/models/NewUser.dart';

class AdminProfile extends StatefulWidget {
  final String uid;
  AdminProfile({this.uid});
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  FirebaseFirestore user;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<NewUser>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            NewUser userData = snapshot.data;
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0x44000000).withOpacity(0.0),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                elevation: 0.0,
                title: Text('Profile',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20.0,
                        color: Colors.white)),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return AdminHome();
          }
        });
  }
}
