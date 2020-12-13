import 'package:bird/components/MessageSnack.dart';
import 'package:bird/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../home.dart';


enum FormType { LOGIN, REGISTER }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // state variables
  String _email, _password, _username;
  String _pageTitle = "Account Login";
  FormType _formType = FormType.LOGIN;
  bool _loading = false;
  @override
  void initState(){
    super.initState();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit(BuildContext context) async {
    if (validate()) {
      try {
        setState(() {
          _loading = true;
        });
        //final auth = Provider.of(context).auth;
        if (_formType == FormType.LOGIN) {
          // Login user using firebase API
          await AuthService().loginUser(email: _email, password: _password);
        } else {
          // Create New User user using firebase API
          await AuthService().createUser(
              email: _email,

              username: _username,
              password: _password);
        }

        setState(() {
          _loading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "HomePage"),
              builder: (BuildContext context) => Home()),
        );
      } catch (e) {
        MessageSnack().showErrorMessage(
            e,
            _scaffoldKey,
                () => {
              setState(() {
                _loading = false;
              })
            });
      } finally {}
    }
  }

  void switchFormState(String state) {
    formKey.currentState.reset();

    if (state == 'register') {
      setState(() {
        _formType = FormType.REGISTER;
        _pageTitle = 'Account Registration';
      });
    } else {
      setState(() {
        _formType = FormType.LOGIN;
        _pageTitle = 'Account Login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Container (
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/tempback.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child:ModalProgressHUD(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: tempWidth/4, right: tempWidth/4, top: 5),

                    child: Column(
                      children: buildInputs(_formType) +
                          [
                            Padding(
                                padding:
                                EdgeInsets.only(left: 0, right: 0, top: 0),
                                child: Row(children: buildButtons(context)))
                          ],
                    ),
                  ),
                ),
              ),
              inAsyncCall: _loading),
        ));
  }
//Color.fromRGBO(28, 28, 28, 1)
//Color.fromRGBO(252,238,10, 1)
  List<Widget> buildInputs(FormType formType) {

    var base = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(300, 0, 300, 0),),
      ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container (
              color: Color.fromRGBO(28, 28, 28, 0.8),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Column(
                      children: <Widget>[
                      Text('numdash',
                      style: TextStyle(fontFamily: 'logo', fontSize: 20, color: Color.fromRGBO(252,238,10, 1))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),),
                        Container(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),

                                child: TextFormField(
                                  onSaved: (value) => _email = value,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide.none,
                                        //borderSide: const BorderSide(),
                                      ),

                                      hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                                      filled: true,
                                      fillColor: Colors.white,

                                      hintText: 'Email'),
                                ))),
                        Container(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),

                                child:
                                TextFormField(
                                  obscureText: true,
                                  onSaved: (value) => _password = value,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(

                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide.none,
                                        //borderSide: const BorderSide(),
                                      ),

                                      hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                                      filled: true,
                                      fillColor: Colors.white,

                                      hintText: 'Password'),
                                ))),

                      ])))),





    ];

    if (formType == FormType.REGISTER) {
      return base;
    } else {
      return base;
    }
  }

  List<Widget> buildButtons(BuildContext context) {
    if (_formType == FormType.LOGIN) {
      return [

        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container (
                color: Color.fromRGBO(252,238,10, 0.8),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Row(
                        children: <Widget>[

                          ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 114), //adds padding inside the button
                            //limits the touch area to the button area
                            minWidth: 0, //wraps child's width
                            height: 0, //wraps child's height
                            child:RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Color.fromRGBO(255, 255, 255, 1),
                              key: new Key('login'),
                              child: Align(alignment: Alignment.center, child: Text('LOG IN')),
                              onPressed: () => submit(context),
                            ),),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10)),
                          ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0), //adds padding inside the button
                            //limits the touch area to the button area
                            minWidth: 0, //wraps child's width
                            height: 0, //wraps child's height
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              key: new Key('goto-register'),
                              color: Color.fromRGBO(205, 205, 205, 1),
                              child: Align(
                                  alignment: Alignment.center, child: Text('REGISTER')),
                              onPressed: () {
                                switchFormState('register');
                              },
                            ),),
                        ]))))];
    } else {
      return [

        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container (
                color: Color.fromRGBO(211, 238, 255, 1),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Row(
                        children: <Widget>[
                          ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 87), //adds padding inside the button
                            //limits the touch area to the button area
                            minWidth: 0, //wraps child's width
                            height: 0, //wraps child's height
                            child:RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Color.fromRGBO(255, 255, 255, 1),

                              key: new Key('create-account'),
                              child:
                              Align(alignment: Alignment.center, child: Text('Create Account')),
                              onPressed: () => submit(context),
                            ),),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10)),

                          ButtonTheme(
                              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 31.0), //adds padding inside the button
                              //limits the touch area to the button area
                              minWidth: 0, //wraps child's width
                              height: 0, //wraps child's height

                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  color: Color.fromRGBO(225, 225, 225, 1),
                                  key: new Key('go-back'),
                                  child: Align(alignment: Alignment.center, child: Text('Back')),
                                  onPressed: () {
                                    switchFormState('login');
                                  })),
                        ]))))];

    }
  }
}

