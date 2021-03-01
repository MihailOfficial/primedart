import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  final VoidCallback signIn;

  RegisterEmailSection({@required this.signIn});

  @override
  State<StatefulWidget> createState() =>
      _RegisterEmailSectionState(signIn: signIn);
}

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
        _errorState = WEAK_STATE;
      } else if (e.code == 'email-already-in-use') {
        _errorState = IN_USE_STATE;
      } else {
        print(e.code);
      }
    }
    if (_success) {
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
        footer: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(15.0),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  padding: const EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.deepPurple,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _register();
                      //print("test");
                    }
                  },
                  child: const Text('Continue',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.yellowAccent,
                        fontFamily: 'pixel',
                      )),
                ),
              ),
            ])),
        child: Container(
            decoration: new BoxDecoration(color: Colors.black),
            child: Container(
                child: SafeArea(
                    child: Container(
              color: Colors.black,
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
                                  fontSize: 28,
                                  color: Colors.yellowAccent,
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
                      child: const Text('Create an account',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'pixel',
                              fontSize: 12,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: const Text(
                          'By continuing, you agree to our User Agreement and Privacy. Your data is protected by Google.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'pixel',
                            fontSize: 8,
                            color: Colors.grey,
                            height: 1.4,
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person_outline,
                            color: Colors.yellowAccent),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'pixel',
                            fontSize: 12),
                        filled: true,
                        fillColor: Color.fromRGBO(40, 40, 40, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(140, 140, 140, 1),
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.yellowAccent, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'pixel',
                          fontSize: 12),
                      controller: _usernameControlller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email,
                            color: Colors.yellowAccent),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'pixel',
                            fontSize: 12),
                        filled: true,
                        fillColor: Color.fromRGBO(40, 40, 40, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(140, 140, 140, 1),
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.yellowAccent, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'pixel',
                          fontSize: 12),
                      controller: _emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Colors.yellowAccent),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'pixel',
                            fontSize: 12),
                        filled: true,
                        fillColor: Color.fromRGBO(40, 40, 40, 1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(140, 140, 140, 1),
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.yellowAccent, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'pixel',
                          fontSize: 12),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
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
                        color: Color.fromRGBO(40, 40, 40, 1),
                        onPressed: () async {
                          signIn.call();
                        },
                        padding: const EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text('im already a numdasher',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                fontFamily: 'pixel')),
                      ),
                    ),
                  ]),
                ),
              ),
            )))));
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
    } on FirebaseAuthException catch (e) {
      print("Error: " + e.code);
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
    return Container(
        color: Colors.red,
        child: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: Colors.red),
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Center(
                              child: Container(
                                  child: Text('NUMDASH',
                                      style: TextStyle(
                                          fontFamily: 'logo',
                                          fontSize: 25,
                                          color: Colors.indigo)))),
                          SizedBox(height: 20),
                          Container(
                            child: const Text('Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: const Text(
                                'By continuing, you agree to our User Agreement and Privacy. Your data is protected by Google.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Color.fromRGBO(240, 240, 240, 1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(210, 210, 210, 1),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
                              ),
                            ),
                            controller: _emailController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Color.fromRGBO(240, 240, 240, 1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(210, 210, 210, 1),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
                              ),
                            ),
                            controller: _passwordController,
                            obscureText: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: Alignment.center,
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _signInWithEmailAndPassword();
                                }
                              },
                              child: const Text('SIGN IN'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _success == null
                                  ? ''
                                  : (_success
                                      ? 'Successfully signed in ' +
                                          _userEmail +
                                          ' (unverified)'
                                      : 'Sign in failed'),
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    )))));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
