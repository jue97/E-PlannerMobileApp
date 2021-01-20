import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:EPlanner/Controller/auth_helper.dart';
import 'package:EPlanner/Shared/constant.dart';
import 'package:EPlanner/Shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
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
                            padding:
                                const EdgeInsets.only(bottom: 32, right: 32),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              height: 300,
                              width: 450,
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: <Widget>[
                                    //email

                                    SizedBox(height: 10.0),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: TextFormField(
                                          decoration: textInputDecoration
                                              .copyWith(hintText: 'Email'),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter an email'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => email = val);
                                          }),
                                    ),
                                    //password
                                    SizedBox(height: 10.0),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: TextFormField(
                                          decoration: textInputDecoration
                                              .copyWith(hintText: 'Password'),
                                          obscureText: true,
                                          validator: (val) => val.length < 6
                                              ? 'Enter a password 6+ chars long'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => password = val);
                                          }),
                                    ),

                                    //login button
                                    SizedBox(height: 10.0),
                                    RaisedButton(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0)),
                                        color: Colors.orange,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() => loading = true);
                                            dynamic result = await AuthService
                                                .signInWithEmail(
                                                    email, password);
                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    'Could not sign in with those credential';
                                                loading = false;
                                              });
                                            }
                                          }
                                        }),
                                    //register button
                                    SizedBox(height: 20.0),
                                    RaisedButton(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(200.0)),
                                      color: Colors.white,
                                      child: Text(
                                        'Register',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        widget.toggleView();
                                      },
                                    ),
                                    SizedBox(height: 12.0),
                                    Text(
                                      error,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )),
                              ))),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

/* Container(
                        child: Image.asset('assets/images/logo2.png',
                         height: 200,
                         width: 200,
                        
                         ),
                        
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  height: 300,
                                  width: 450,
                                  child: Form(
                                    key: _formKey,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: <Widget>[
                                        //email

                                        SizedBox(height: 10.0),
                                        TextFormField(
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Email'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter an email'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => email = val);
                                            }),
                                        //password
                                        SizedBox(height: 10.0),
                                        TextFormField(
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Password'),
                                            obscureText: true,
                                            validator: (val) => val.length < 6
                                                ? 'Enter a password 6+ chars long'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => password = val);
                                            }),

                                        //login button
                                        SizedBox(height: 10.0),
                                        RaisedButton(
                                            color: Colors.pink[400],
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() => loading = true);
                                                dynamic result =
                                                    await AuthService
                                                        .signInWithEmail(
                                                            email, password);
                                                if (result == null) {
                                                  setState(() {
                                                    error =
                                                        'Could not sign in with those credential';
                                                    loading = false;
                                                  });
                                                }
                                              }
                                            }),
                                        //register button
                                        SizedBox(height: 20.0),
                                        RaisedButton(
                                          color: Colors.white,
                                          child: Text(
                                            'Register',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            widget.toggleView();
                                          },
                                        ),
                                        SizedBox(height: 12.0),
                                        Text(
                                          error,
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )
                                    ),
                                  )
                                )
                              )
                            )*/
