import 'package:blinking_text/blinking_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'highscore_functions.dart';

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
  Future<List<DocumentSnapshot>> highscores = getHighScores(5);
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
                  decoration: new BoxDecoration(color: Color.fromRGBO(20, 20, 20, 0)),
                  child: Container(
                      child: SafeArea(
                          child: Container(
                              child: Scaffold(
                                  body: Container(
                                      decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/886041.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                      child: Column(children: <Widget>[
                                        SizedBox(height: 20),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40.0),
                                          child:Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      child: Text('NumDash',
                                                          style: TextStyle(
                                                            fontFamily: 'rage',
                                                            fontSize: 40,
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

                                      ButtonTheme(
                                          minWidth: 20.0,
                                          child:
                                                  MaterialButton(

                                                      onPressed: () =>
                                                          setState(() {
                                                            signOut.call();
                                                          }),
                                                      color:
                                                      Color.fromRGBO(20, 20, 20, 0.1),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                      ),
                                                      child: Icon(
                                                        Entypo.getIconData(
                                                            "log-out"),
                                                        color:
                                                            Colors.white,
                                                      )),
                                      ) ])),
                                        SizedBox(height: 10),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                        child:
                                        Container(

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 3.0,
                                              color: Colors.grey,
                                            ),
                                            color:
                                            Color.fromRGBO(20, 20, 20, 0.8),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 10),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[

                                            Container(

                                              child: const Text('GLOBAL SCORES',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'pixel',
                                                      fontSize: 15,
                                                      color: Colors.amber)),
                                            ),
                                            ButtonTheme(
                                                minWidth: 20.0,
                                                child: MaterialButton(

                                                onPressed: () async {setState(() {
                                                  highscores = getHighScores(5);
                                                });},
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                                ),

                                                child: Icon(
                                                  Icons.refresh,
                                                  color:
                                                  Colors.white,
                                                )
                                            )),])),

                                            FutureBuilder(
                                              future: Future.wait([highscores,getMyScore()]),
                                              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                                                if(snapshot.hasData){
                                                  return DataTable(
                                                    columnSpacing: 20,
                                                      dataRowHeight: 20,
                                                    columns: const <
                                                      DataColumn>[
                                                    DataColumn(
                                                      label:  Text(
                                                        'Rank',
                                                        style: TextStyle(

                                                            fontFamily: 'pixel',
                                                            fontSize: 10,
                                                            color: Colors.white),
                                                      ),),
                                                    DataColumn(
                                                      label: Text(
                                                        'Username',
                                                        style: TextStyle(


                                                            fontFamily: 'pixel',
                                                            fontSize: 10,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Text(
                                                        'Score',
                                                        style: TextStyle(

                                                            fontFamily: 'pixel',
                                                            fontSize: 10,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ], rows: <DataRow>[

                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                          '1',
                                                          style: TextStyle(
                                                              fontStyle:
                                                              FontStyle.italic,
                                                              fontFamily: 'pixel',
                                                              fontSize: 12,
                                                              color: Colors.yellowAccent),
                                                        )),
                                                        DataCell(
                                                      SizedBox(width: 160,

                                                      child:
                                                            Text(snapshot.data[0][0].get("username").toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[0][0].get("current_best").toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
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
                                                                color: Colors.yellowAccent))),
                                                        DataCell(
                                                SizedBox(width: 160,

                                                child:
                                                Text(snapshot.data[0][1].get("username").toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[0][1].get("current_best").toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
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
                                                                Colors.yellowAccent))),
                                                        DataCell(
                                                SizedBox(width: 160,

                                                child:

                                                Text(snapshot.data[0][2].get("username").toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[0][2].get("current_best").toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell( Text('4',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 12,
                                                                color:
                                                                Colors.yellowAccent))),
                                                        DataCell(
                                                            SizedBox(width: 160,

                                                                child:

                                                                Text(snapshot.data[0][3].get("username").toString(),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                        FontStyle.italic,
                                                                        fontFamily: 'pixel',
                                                                        fontSize: 10,
                                                                        color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[0][3].get("current_best").toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell( Text('5',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 12,
                                                                color:
                                                                Colors.yellowAccent))),
                                                        DataCell(
                                                            SizedBox(width: 160,

                                                                child:

                                                                Text(snapshot.data[0][4].get("username").toString(),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                        FontStyle.italic,
                                                                        fontFamily: 'pixel',
                                                                        fontSize: 10,
                                                                        color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[0][4].get("current_best").toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
                                                      ],
                                                    ),
                                                    DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(
                                                Text('29',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 12,
                                                                color: Colors.yellowAccent))),
                                                        DataCell(SizedBox(width: 160,

                                                child:
                                                Text(FirebaseAuth.instance.currentUser.displayName,
                                                    overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey)))),
                                                        DataCell(Text(snapshot.data[1].toString(),
                                                            style: TextStyle(
                                                                fontStyle:
                                                                FontStyle.italic,
                                                                fontFamily: 'pixel',
                                                                fontSize: 10,
                                                                color: Colors.blueGrey))),
                                                      ],
                                                    ),

                                                  ]);
                                                } else if(snapshot.hasError){
                                                  print("alert");
                                                  print(snapshot.error);
                                                  return CircularProgressIndicator();
                                                } else {
                                                  return CircularProgressIndicator();
                                                }
                                              }
                                            ),

                                            SizedBox(height: 20),

                                          ]),
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child:
                                      ButtonTheme(
                                        minWidth: double.infinity,
                                          height: 50.0,
                                          child:MaterialButton(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(color: Colors.grey, width: 3),
                                                  borderRadius:BorderRadius.circular(10.0),
                                                ),
                                                color: Color.fromRGBO(20, 20, 20, 0.8),
                                                onPressed: () => setState(() {
                                                  playGame = true;
                                                  pauseGame = false;
                                                }),
                                                child: BlinkText(
                                                  'INSERT COIN',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.yellowAccent,
                                                    fontFamily: 'pixel',
                                                  ),
                                                  endColor: Colors.red,
                                                ),
                                              ),
                                      ))]))
                                      ))))));
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
