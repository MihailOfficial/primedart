import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:flutter_icons/ionicons.dart';

import 'game.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;

  Home({@required this.signOut});

  @override
  _HomeState createState() => _HomeState(signOut: signOut);
}

class _HomeState extends State<Home> {
  static const String routeName = "/home";
  final VoidCallback signOut;

  _HomeState({@required this.signOut});

  bool playGame = false;

  @override
  Widget build(BuildContext context) {
    if (!playGame) {
      contexts = context;
      var screenHeight = MediaQuery.of(context).size.height;
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      return MaterialApp(
          home:
              //Scaffold(
              // drawer: AppDrawer(),
              // body:
              Container(
                  decoration: new BoxDecoration(color: Colors.black),
                  child: Container(
                      child: SafeArea(
                          child: Container(
                              child: Scaffold(
                                  body: Container(
                                      color: Colors.black,
                                      child: Column(children: <Widget>[
                                        SizedBox(height: 20),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      child: Text('NumDash',
                                                          style: TextStyle(
                                                            fontFamily: 'rage',
                                                            fontSize: 28,
                                                            color: Colors
                                                                .yellowAccent,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    5.0, 5.0),
                                                                blurRadius: 3.0,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        240,
                                                                        240,
                                                                        240,
                                                                        0.2),
                                                              ),
                                                              Shadow(
                                                                offset: Offset(
                                                                    5.0, 5.0),
                                                                blurRadius: 8.0,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        240,
                                                                        240,
                                                                        240,
                                                                        0.2),
                                                              ),
                                                            ],
                                                          ))),
                                                  MaterialButton(

                                                      onPressed: () =>
                                                          setState(() {
                                                            signOut.call();
                                                          }),

                                                      child: Icon(
                                                        Entypo.getIconData(
                                                            "log-out"),
                                                        color:
                                                            Colors.yellowAccent,
                                                      )),
                                                ])),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(20, 20, 20, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 0),
                                              child: const Text('GLOBAL SCORES',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'pixel',
                                                      fontSize: 14,
                                                      color:
                                                          Colors.yellowAccent)),
                                            ),
                                            DataTable(columns: const <
                                                DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Rank',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily: 'pixel',
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Username',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily: 'pixel',
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Score',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontFamily: 'pixel',
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ], rows: const <DataRow>[
                                              DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text(
                                                    '1',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontFamily: 'pixel',
                                                        fontSize: 12,
                                                        color: Colors.red),
                                                  )),
                                                  DataCell(Text('snowball',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                  DataCell(Text('25052',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                ],
                                              ),
                                              DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text('2',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 12,
                                                          color: Colors.blue))),
                                                  DataCell(Text('aurko',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                  DataCell(Text('7527',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                ],
                                              ),
                                              DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text('3',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 12,
                                                          color:
                                                              Colors.green))),
                                                  DataCell(Text('Becka',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                  DataCell(Text('05025',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              200,
                                                              1)))),
                                                ],
                                              ),
                                              DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text('X',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 12,
                                                          color: Colors.grey))),
                                                  DataCell(Text('You',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Colors.grey))),
                                                  DataCell(Text('05025',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontFamily: 'pixel',
                                                          fontSize: 10,
                                                          color: Colors.grey))),
                                                ],
                                              ),
                                            ]),
                                           MaterialButton(
                                                color: Color.fromRGBO(
                                                    20, 20, 20, 1),
                                                onPressed: () async {},



                                                child: const Text('Refresh',
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.grey,
                                                        fontFamily: 'pixel')),
                                              ),

                                          ]),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 3.0,
                                                color: Colors.yellowAccent,
                                              ),
                                              color:
                                                  Color.fromRGBO(20, 20, 20, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            child: Column(children: <Widget>[
                                              Container(
                                                child: const BlinkText(
                                                  'INSERT COIN TO PLAY',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.yellowAccent,
                                                    fontFamily: 'pixel',
                                                  ),
                                                  endColor: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              RaisedButton(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                color: Colors.deepPurple,
                                                onPressed: () => setState(() {
                                                  playGame = true;
                                                  pauseGame = false;
                                                }),
                                                child: Text(
                                                  'INSERT COIN',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.yellowAccent,
                                                    fontFamily: 'pixel',
                                                  ),
                                                ),
                                              ),
                                            ]))
                                      ]))))))));
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onboarding Concept',
        home: Builder(
          builder: (BuildContext context) {
            var screenHeight = MediaQuery.of(context).size.height;
            return Container(child: Game());
          },
        ),
      );
    }
  }
}
