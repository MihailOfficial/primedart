import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
class RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  final VoidCallback signIn;

  RegisterEmailSection({@required this.signIn});

  @override
  State<StatefulWidget> createState() =>
      _RegisterEmailSectionState(signIn: signIn);
}

bool error = false;
bool error2 = false;

class _RegisterEmailSectionState extends State<RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameControlller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final VoidCallback signIn;

  bool _success;
  String _userEmail;
  int _errorState = NONE_STATE;
  static const int NONE_STATE = 0, IN_USE_STATE = 1, WEAK_STATE = 2;

  _RegisterEmailSectionState({@required this.signIn});

  void _register() async {
    UserCredential userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _success = true;
    } on FirebaseAuthException catch (e) {
      _success = false;
      if (e.code == 'weak-password') {
        Flushbar(
          messageText: Text(
            "WEAK PASSWORD",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
 ),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
          duration: Duration(seconds: 2),
        )..show(context);
        _errorState = WEAK_STATE;
      } else if (e.code == 'email-already-in-use') {
        Flushbar(
          messageText: Text(
            "EMAIL IN USE",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
          duration: Duration(seconds: 2),
        )..show(context);
        _errorState = IN_USE_STATE;
      } else if (e.code == 'invalid-email') {
        Flushbar(
          messageText: Text(
            "Invalid email",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
          duration: Duration(seconds: 2),
        )..show(context);
        _errorState = IN_USE_STATE;
      } else {
        print(e.code);
      }
    }
    if (_success) {
      Flushbar(
        messageText: Text(
          "SUCCESSFUL LOGIN",
          style: TextStyle(
              fontSize: 18.0, color: Colors.red),
        ),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.red,
        ),
        leftBarIndicatorColor: Colors.red,
        duration: Duration(seconds: 2),
      )..show(context);
      userCredential.user.updateProfile(displayName: _usernameControlller.text);
      //userCredential.user.sendEmailVerification();
      setState(() {
        _userEmail = userCredential.user.email;
      });
      signIn.call();
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Color.fromRGBO(253, 150, 151, 1),
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
                        color: Colors.black,

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
                    SizedBox(height: 20),
                    Container(
                      child: const Text(
                          'Create Account',
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              fontSize:
                              26,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 10),
                    Container(

                      child: const Text(
                          'By continuing, you agree to our User Agreement and Privacy. Your data is protected by Google.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.4,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        hintText: 'USERNAME',
                        prefixIcon: Icon(Icons.person_outline,
                            color: Colors.red),
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
                              BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _usernameControlller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          if (!error) {
                            error = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                                    ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        hintText: 'EMAIL',
                        prefixIcon: Icon(Icons.alternate_email,
                            color: Colors.red),
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
                              BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          if (!error) {
                            error = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                                   ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        hintText: 'PASSWORD',
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.red),
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
                              BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          if (!error) {
                            error = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                                    ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_success == null
                          ? ''
                          : (_success
                              ? 'Successfully registered ' + _userEmail
                              : 'Registration failed')),
                    ),
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
                    ),
                  ]),
                ),
              ),
            ))));
  }
}

class EmailPasswordForm extends StatefulWidget {
  final VoidCallback loggedIn;

  EmailPasswordForm({@required this.loggedIn});

  @override
  State<StatefulWidget> createState() =>
      EmailPasswordFormState(loggedIn: loggedIn);
}

class EmailPasswordFormState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final VoidCallback loggedIn;
  bool _success;
  String _userEmail;

  EmailPasswordFormState({@required this.loggedIn});

  void _signInWithEmailAndPassword() async {
    UserCredential userCredentials;
    try {
      _success = true;
      userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Flushbar(
        messageText: Text(
          "SUCCESSFUL LOGIN",
          style: TextStyle(
              fontSize: 18.0, color: Colors.red, ),
        ),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.check,
          size: 28.0,
          color: Colors.red,
        ),
        leftBarIndicatorColor: Colors.red,
        duration: Duration(seconds: 2),
      )..show(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Flushbar(
          messageText: Text(
            "WRONG PASSWORD",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
          ),
          leftBarIndicatorColor: Colors.red,
          duration: Duration(seconds: 2),
        )..show(context);
      }
      _success = false;
    }
    if (_success) {
      setState(() {
        _userEmail = userCredentials.user.email;
        loggedIn.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FooterLayout(
        footer: Container(
            color: Color.fromRGBO(20, 20, 20, 0),
            padding: const EdgeInsets.all(15.0),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromRGBO(253, 150, 151, 1),
                  onPressed: () async {
                    error2 = false;
                    if (_formKey.currentState.validate()) {
                      _signInWithEmailAndPassword();
                    }
                  },
                  child: const Text('CONTINUE',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,

                      )),
                ),
              ),
            ])),
        child: Container(
            decoration: new BoxDecoration(color: Color.fromRGBO(20, 20, 20, 0)),
            child: Container(
                child: Container(
              color: Color.fromRGBO(20, 20, 20, 0),
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
                    SizedBox(height: 20),
                    Container(
                      child: const Text('Sign In',
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              fontSize:
                              26,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: const Text(
                          'By continuing, you agree to our User Agreement and Privacy. Your data is protected by Google.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,

                            fontSize: 14,
                            color: Colors.white,
                            height: 1.4,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'EMAIL',
                        prefixIcon: Icon(Icons.alternate_email,
                            color: Colors.red),
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
                              BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          if (!error2) {
                            error2 = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                       ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'PASSWORD',
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.red),
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
                              BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 20),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          if (!error2) {
                            error2 = true;
                            Flushbar(
                              messageText: Text(
                                "BLANK INPUT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red,
                       ),
                              ),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: Icon(
                                Icons.error_outline,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )..show(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_success == null
                          ? ''
                          : (_success
                              ? 'Successfully registered ' + _userEmail
                              : 'Registration failed')),
                    ),
                  ]),
                ),
              ),
            ))));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
