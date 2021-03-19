import 'dart:ui';

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
                  child: Container(
                      child: SafeArea(
                          child: Container(

                              child: Scaffold(
                                  body: Container(

                                      decoration: BoxDecoration(

                                        image: DecorationImage(

                                          image: AssetImage(
                                              "assets/images/teset.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(

                                      child:Column(children: <Widget>[
                                        SizedBox(height: 20),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),// <-- clips to the 200x200 [Container] below
                                              child:BackdropFilter(

                                              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                              decoration: BoxDecoration(
                                              color: Color.fromRGBO(20, 20, 20, 0.6),

                                              borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                              ),

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                              Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10,),
                                                  child:
                                                  Container(
                                                      child: Text(' NumDash',
                                                          style: TextStyle(
                                                            fontFamily: "rage",
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
                                                          )))),
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 20.0),
                                                      child: ButtonTheme(
                                                    minWidth: 20.0,
                                                    child: MaterialButton(
                                                        onPressed: () =>
                                                            setState(() {
                                                              signOut.call();
                                                            }),
                                                        color: Colors.indigo,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Icon(
                                                          Entypo.getIconData(
                                                              "log-out"),
                                                          color: Colors.white,
                                                        )),
                                                  ))
                                                ]))))),
                                        SizedBox(height: 10),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child:Container(
                                              decoration: BoxDecoration(
                                                /*border: Border.all(
                                                  width: 3.0,
                                                  color: Colors.grey,
                                                ),*/

                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child:ClipRRect(
                                                  borderRadius: BorderRadius.circular(12.0),// <-- clips to the 200x200 [Container] below
                                                  child:BackdropFilter(

                                                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(20, 20, 20, 0.6),

                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(12)),
                                                    ),

                                                    child: Column(children: <Widget>[
                                                SizedBox(height: 10),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            child: const Text(
                                                                'GLOBAL SCORES',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors.white)),
                                                          ),
                                                          ButtonTheme(
                                                              minWidth: 20.0,
                                                              child:
                                                                  MaterialButton(
                                                                      onPressed:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          highscores =
                                                                              getHighScores(5);
                                                                        });
                                                                      },
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .refresh,
                                                                        color: Colors
                                                                            .white,
                                                                      ))),
                                                        ])),
                                                FutureBuilder(
                                                    future: Future.wait([
                                                      highscores,
                                                      getMyScore()
                                                    ]),
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<List>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Theme(
                                                            data: Theme.of(context).copyWith(
                                                                dividerColor: Color.fromRGBO(0, 0, 0, 0)
                                                            ),
                                                            child:DataTable(
                                                            columnSpacing: 20,
                                                            dataRowHeight: 20,
                                                            columns: const <
                                                                DataColumn>[
                                                              DataColumn(
                                                                label: Text(
                                                                  'Rank',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      color: Colors
                                                                          .amber),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                  'Username',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      color: Colors
                                                                          .amber),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                  'Score',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      color: Colors
                                                                          .amber),
                                                                ),
                                                              ),
                                                            ],
                                                            rows: <DataRow>[
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                    '1',
                                                                    style: TextStyle(
                                                                          
                                                                        fontSize:
                                                                            19,
                                                                        color: Colors
                                                                            .yellowAccent),
                                                                  )),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          snapshot.data[0][0]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(
                                                                                 
                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                              [
                                                                              0]
                                                                          .get(
                                                                              "current_best")
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '2',
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.yellowAccent))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          snapshot.data[0][1]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                              [
                                                                              1]
                                                                          .get(
                                                                              "current_best")
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '3',
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.yellowAccent))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          snapshot.data[0][2]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                              [
                                                                              2]
                                                                          .get(
                                                                              "current_best")
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '4',
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.yellowAccent))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          snapshot.data[0][3]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                              [
                                                                              3]
                                                                          .get(
                                                                              "current_best")
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '5',
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.yellowAccent))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          snapshot.data[0][4]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              0]
                                                                              [
                                                                              4]
                                                                          .get(
                                                                              "current_best")
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '29',
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.yellowAccent))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                          160,
                                                                      child: Text(
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 19,
                                                                              color: Colors.grey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              1]
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                          Colors.grey))),
                                                                ],
                                                              ),
                                                            ]));
                                                      } else if (snapshot
                                                          .hasError) {
                                                        print("alert");
                                                        print(snapshot.error);
                                                        return CircularProgressIndicator();
                                                      } else {
                                                        return CircularProgressIndicator();
                                                      }
                                                    }),
                                                SizedBox(height: 20),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.yellowAccent.withOpacity(0.2),


                                                        ),
                                                    child:
                                                    Column(children: <Widget>[
                                                      SizedBox(height: 10),
                                                    Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 30.0),
                                                        child:
                                                      Container(
                                                        child: const Text(
                                                            'START GAME',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w900,
                                                                fontSize:
                                                                25,
                                                                color: Colors.white)),
                                                      ),),
                                                      SizedBox(height: 10),
                                                    Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 30.0),
                                                        child:
                                                      ButtonTheme(
                                                        minWidth: double.infinity,
                                                        height: 50.0,
                                                        child: MaterialButton(
                                                          padding:
                                                          const EdgeInsets.all(10.0),
                                                          shape: RoundedRectangleBorder(
                                                            /*side: BorderSide(
                                                      color: Colors.grey,
                                                      width: 3),*/
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10.0),
                                                          ),
                                                          color: Colors.indigo,
                                                          onPressed: () => setState(() {
                                                            playGame = true;
                                                            pauseGame = false;
                                                          }),
                                                          child: BlinkText(
                                                            'INSERT COIN',
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: Colors.yellowAccent,
                                                            ),
                                                            endColor: Colors.red,
                                                          ),
                                                        ),
                                                      ),),SizedBox(height: 10),])),

                                              ])),
                                            )))),
                                        SizedBox(
                                          height: 10,
                                        ),

                                      ])))))))));
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
