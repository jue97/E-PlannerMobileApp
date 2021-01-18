import 'package:flutter/material.dart';
import 'package:sampleproject/View/register.dart';
import 'package:sampleproject/View/sign_in.dart';


class Handler extends StatefulWidget {
  @override
  _HandlerState createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn  = !showSignIn );
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}