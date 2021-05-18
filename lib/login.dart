import 'package:bad_words/bad_words.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'highscore_functions.dart';
import 'package:sizer/sizer.dart';

class RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  final VoidCallback signIn;

  RegisterEmailSection({@required this.signIn});

  @override
  State<StatefulWidget> createState() =>
      _RegisterEmailSectionState(signIn: signIn);
}

bool error = false;
bool badName = false;
bool error2 = false;

class _RegisterEmailSectionState extends State<RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final VoidCallback signIn;

  bool _success;
  String _userEmail;
  int _errorState = NONE_STATE;
  static const int NONE_STATE = 0, IN_USE_STATE = 1, WEAK_STATE = 2;

  _RegisterEmailSectionState({@required this.signIn});


  void _register() async {
    bool _success = await createUser(_usernameController.text);
    if (_success && !badName) {
      Flushbar(
        messageText: Text(
          "SUCCESSFUL LOGIN",
          style: TextStyle(
              fontSize: 18.0, color: Colors.yellow),
        ),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.yellow,
        ),
        leftBarIndicatorColor: Colors.yellow,
        duration: Duration(seconds: 2),
      )..show(context);
      setState(() {
        _userEmail = _usernameController.text;
      });
      signIn.call();
    } else if (badName){

      }
      else {
      Flushbar(
        messageText: Text(
          "TOO MANY BOOKED",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.yellow,
          ),
        ),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.yellow,
        ),
        leftBarIndicatorColor: Colors.yellow,
        duration: Duration(seconds: 2),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = Filter();
    return FooterLayout(

        footer:Container(


            padding: const EdgeInsets.all(15.0),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () async {
                    error = false;
                    if (_formKey.currentState.validate()) {
                      _register();
                      //print("test");
                    }
                  },
                  child: const Text('CONTINUE',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.yellow,

                      )),
                ),
              ),
            ])),
        child: Container(

            child: Container(

                child:Container(
                      decoration: new BoxDecoration(color: Color.fromRGBO(10, 10, 10, 0)),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(shrinkWrap: true, children: <Widget>[
                    SizedBox(height: 20),

                    Center(
                        child: Container(
                            child: Text('NumDash',
                                style: TextStyle(
                                  fontFamily: 'rage',
                                  fontSize: 34,
                                  color: Colors.yellow,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 3.0,
                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                    ),
                                    Shadow(
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 8.0,
                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                    ),
                                  ],
                                )))),
                    SizedBox(height: 40),
                    Container(
                      child: const Text(
                          'Pick a username',
                          style: TextStyle(
                              fontSize: 35.0,
                              fontFamily:
                              "sansSar",
                              color: Colors
                                  .lightBlueAccent)),
                    ),
                    SizedBox(height: 10),
                    Container(

                      child: const Text(
                          'Enter your global username. Profanity is filtered.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.4,
                          )),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person_outline,
                            color: Colors.yellow),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18),
                        filled: true,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(80, 80, 80, 1),
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _usernameController,
                      validator: (String value) {
                        badName = false;
                        bool hasProfanity = filter.isProfane(value);
                        if (value.isEmpty) {
                          if (!error) {
                            error = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.yellow,
                                    ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.yellow,
                              ),
                              leftBarIndicatorColor: Colors.yellow,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                        if (hasProfanity) {
                          badName = true;
                            Flushbar(
                              messageText: Text(
                                "Profanity Detected!",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.yellow,
                                ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.yellow,
                              ),
                              leftBarIndicatorColor: Colors.yellow,
                              duration: Duration(seconds: 2),
                            )..show(context);


                        }

                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_success == null ? '' : (_success
                              ? 'Successfully registered ' + _userEmail
                              : 'Registration failed')),
                    ),
                    /*
                    Container(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        color: Color.fromRGBO(60, 60, 60, 1),
                        onPressed: () async {
                          signIn.call();
                        },
                        padding: const EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text("I HAVE AN ACCOUNT",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                               )),
                      ),
                    ),*/
                  ]),
                ),
              ),
            ))));
  }
}
