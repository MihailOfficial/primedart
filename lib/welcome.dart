import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'main.dart';
import 'game.dart';
class Welcomer1 extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcomer1> {
  bool playGame = false;

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                  child: Container(
                      child: Column(children: <Widget>[
                        Container(
                            width: double.infinity,
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('NumDash',
                                          style: TextStyle(
                                            fontFamily: 'rage',
                                            fontSize: 28.0.sp,
                                            color: Colors.yellow,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(5.0, 5.0),
                                                blurRadius: 3.0,
                                                color: Color.fromRGBO(
                                                    240, 240, 240, 0.2),
                                              ),
                                              Shadow(
                                                offset: Offset(5.0, 5.0),
                                                blurRadius: 8.0,
                                                color: Color.fromRGBO(
                                                    240, 240, 240, 0.2),
                                              ),
                                            ],
                                          ))
                                    ]))),
                        SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    // <-- clips to the 200x200 [Container] below
                                    child: BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 20.0, sigmaY: 20.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                            border: Border.all(
                                                color: Colors.white,
                                                // set border color
                                                width: 1.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                Color.fromRGBO(250, 250, 250, 0),
                                                Color.fromRGBO(250, 250, 250, 0)
                                              ],
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 20),
                                            Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                            'Welcome!',
                                                            style: TextStyle(
                                                                fontSize: 25.0.sp,
                                                                fontFamily:
                                                                "sansSar",
                                                                color: Colors
                                                                    .lightBlueAccent)),
                                                      ),

                                                    ])),
                                            SizedBox(height: 10),
                                            Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Container(
                                                  child: Text(
                                                      'Test your numerical genius in an intense, timed matching game. Compete with other players and pit your aptitude against each other to try and secure a spot on the global leaderboard. Weekly rewards obtained by high-ranking players.',
                                                      textAlign: TextAlign.justify,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors
                                                              .blueGrey)),

                                                )),
                                            SizedBox(height: 20),
                                            SizedBox(height: 10),
                                          ])),
                                    )))),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              // <-- clips to the 200x200 [Container] below
                              child: BackdropFilter(
                                filter: new ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          color: Colors.yellow, // set border color
                                          width: 1.0),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                          Color.fromRGBO(60, 60, 60, 0),
                                          Color.fromRGBO(130, 130, 130, 0)
                                        ],
                                      ),
                                    ),
                                    child: Column(children: <Widget>[
                                      SizedBox(height: 20),
                                      Container(
                                        child: Text('Press to Continue',
                                            style: TextStyle(
                                                fontSize: 25.0.sp,
                                                fontFamily: "sansSar",
                                                color: Colors.lightBlueAccent)),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: ButtonTheme(
                                          minWidth: double.infinity,
                                          height: 50.0,
                                          child: MaterialButton(
                                            padding: const EdgeInsets.all(10.0),
                                            shape: RoundedRectangleBorder(

                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            color: Colors.blueGrey,
                                            onPressed: () => setState(() {

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => MyHomePage(title: "primedart")),

                                              );
                                            }),
                                            child: Text(
                                              '- ONLINE -',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: ButtonTheme(
                                          minWidth: double.infinity,
                                          height: 50.0,
                                          child: MaterialButton(
                                            padding: const EdgeInsets.all(10.0),
                                            shape: RoundedRectangleBorder(
                                              /*side: BorderSide(
                              color: Colors.grey,
                              width: 3),*/
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            color: Color.fromRGBO(36, 36, 36, 1),
                                            onPressed: () => setState(() {

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Game(tempt: false)),

                                              );
                                              pauseGame = false;

                                            }),
                                            child: Text(
                                              'OFFLINE',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ])),
                              ),
                            ))
                      ])))));

    }
  }

