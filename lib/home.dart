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

              Scaffold(
                  body: Container(
                      color: Colors.black,
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: const Text('GLOBAL SCORES',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pixel',
                                            fontSize: 14,
                                            color: Colors.yellowAccent)),
                                  ),
                                  MaterialButton(
                                      color: Color.fromRGBO(40, 40, 40, 1),
                                      onPressed: () => setState(() {
                                        signOut.call();
                                      }),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Icon(
                                        Entypo.getIconData("log-out"),
                                        color: Colors.yellowAccent,
                                      )),
                                ])),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(20, 20, 20, 1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: DataTable(columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Rank',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'pixel',
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Username',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'pixel',
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Score',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
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
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'pixel',
                                      fontSize: 12,
                                      color: Colors.red),
                                )),
                                DataCell(Text('snowball',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                                DataCell(Text('25052',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('2',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 12,
                                        color: Colors.blue))),
                                DataCell(Text('aurko',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                                DataCell(Text('7527',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('3',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 12,
                                        color: Colors.green))),
                                DataCell(Text('Becka',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                                DataCell(Text('05025',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('X',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 12,
                                        color: Colors.grey))),
                                DataCell(Text('You',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color: Colors.grey))),
                                DataCell(Text('05025',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'pixel',
                                        fontSize: 10,
                                        color: Colors.grey))),
                              ],
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            color: Color.fromRGBO(20, 20, 20, 1),
                            onPressed: () async {},
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text('Refresh',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    fontFamily: 'pixel')),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          padding: const EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.deepPurple,
                          onPressed: () => setState(() {
                            playGame = true;
                          }),
                          child: const BlinkText(
                            'INSERT TOKEN',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.yellowAccent,
                              fontFamily: 'pixel',
                            ),
                            endColor: Colors.orangeAccent,
                          ),
                        ),
                      ]))));
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
