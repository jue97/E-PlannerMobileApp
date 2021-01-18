import 'package:flutter/material.dart';
import 'package:sampleproject/Controller/auth_helper.dart';
import 'package:sampleproject/Shared/constant.dart';
import 'package:sampleproject/Shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  //text field state
  String id = '';
  String name = '';
  String email = '';
  String phoneNum = '';
  String userType = '';
  String password = '';
  String _selectedType;

  List<String> uType = <String>['Organizer', 'Student'];

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            body: Container(
                child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFf45d27),
                        Color(0xFFf5851f),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 4.0),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Username'),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter a username' : null,
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    }),
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                    //keyboardType: TextInputType.emailAddress,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Email'),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    }),
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'PhoneNum'),
                                    validator: (val) => val.isEmpty
                                        ? 'Enter your phone number'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => phoneNum = val);
                                    }),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  hint: Text('Sign Up As'),
                                  validator: (value) => value == null
                                      ? 'What would you like to sign up as?'
                                      : null,
                                  value: _selectedType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedType = newValue;
                                      userType = _selectedType;
                                    });
                                  },
                                  items: uType.map((userType) {
                                    return DropdownMenuItem(
                                      child: new Text(userType),
                                      value: userType,
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Password'),
                                    obscureText: true,
                                    validator: (val) => val.length < 6
                                        ? 'Enter a password 6+ chars long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    }),
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RaisedButton(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(200.0)),
                                      color: Colors.orange,
                                      child: Text(
                                        'Register',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  name,
                                                  email,
                                                  phoneNum,
                                                  userType,
                                                  password);
                                          if (result == null) {
                                            setState(() {
                                              error = 'Error Logging';
                                              loading = false;
                                            });
                                          }
                                        }
                                      }),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                error,
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              RaisedButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200.0)),
                                color: Colors.white,
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  widget.toggleView();
                                },
                              ),
                            ],
                          )),
                    ),
                  ))
            ])));
  }
}
