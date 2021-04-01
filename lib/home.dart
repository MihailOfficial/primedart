import 'dart:io';
import 'dart:ui';

import 'package:blinking_text/blinking_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:sizer/sizer.dart';
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
      return
          Scaffold(
         body:
              Container(

                                      decoration: BoxDecoration(

                                        image: DecorationImage(

                                          image: AssetImage(
                                              "assets/images/485d3de9570a51ae604d6646a81e519e.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child:SafeArea(
                                          child:

                                      Container(
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                      child:Column(children: <Widget>[

                                        Container(
                                          width: double.infinity,



                                            child:Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                    Shadow(
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 8.0,
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                  ],
                                                ))]))),
                                        SizedBox(height: 10),
                                            Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[

                                                  Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10.0, vertical: 10,),
                                                  child:Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                  Container(
                                                      child: Text(
                                                          "welcome:",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                              fontSize: 14.0.sp,
                                                              )),
                                              ),
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
                                                        return Container(child: Text(
                                                          (FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              .displayName),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            color: Colors.white,
                                                            fontSize: 16.0.sp,
                                                          )),
                                                    );} else if (snapshot
                                                              .hasError) {
                                                          print("alert");
                                                          print(snapshot.error);
                                                          return CircularProgressIndicator();
                                                          } else {
                                                          return CircularProgressIndicator();
                                                          }
                                                        }),
                                                  ]

                                              ),),
                                                  ClipOval(
                                                    child: Material(
                                                      color: Color.fromRGBO(50, 50, 50, 1), // button color
                                                      child: InkWell(
                                                        splashColor: Colors.red, // inkwell color
                                                        child: SizedBox(width: 46, height: 46, child: Icon(
                                                          Entypo.getIconData(
                                                              "log-out"),
                                                          color:
                                                          Colors.white,
                                                        ),),
                                                        onTap: () =>
                                                            setState(() {
                                                              signOut.call();
                                                            }),
                                                      ),
                                                    ),
                                                  ),


                                                ])),


                                        SizedBox(height: 10),
                                        Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(

                                              child:ClipRRect(
                                                  borderRadius: BorderRadius.circular(30.0),// <-- clips to the 200x200 [Container] below
                                                  child:BackdropFilter(

                                                filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                        border: Border.all(
                                                            color: Colors.white,// set border color
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
                                                SizedBox(height: 10),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 30.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            child:  Text(
                                                                'Global Scores',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: 20.0.sp,
                                                                    color:Colors.lightBlueAccent)),
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
                                                                        color: Colors.white,
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
                                                            columns:  <
                                                                DataColumn>[
                                                              DataColumn(
                                                                label: Text(
                                                                  'RANK',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 15.0.sp,
                                                                      color: Color.fromRGBO(150, 150, 150, 1)),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(

                                                                  'NAME',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 15.0.sp,
                                                                      color: Color.fromRGBO(150, 150, 150, 1)),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Text(
                                                                  'SCORE',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w900,
                                                                      fontSize: 15.0.sp,
                                                                      color:  Color.fromRGBO(150, 150, 150, 1)),
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
                                                                        fontWeight: FontWeight.w900,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Colors.blueGrey),
                                                                  )),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          snapshot.data[0][0]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
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
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '2',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          snapshot.data[0][1]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
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

                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '3',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          snapshot.data[0][2]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
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

                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '4',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          snapshot.data[0][3]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
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

                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '5',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          snapshot.data[0][4]
                                                                              .get(
                                                                                  "username")
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
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

                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                ],
                                                              ),
                                                              DataRow(
                                                                cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      '29',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
                                                                  DataCell(SizedBox(
                                                                      width:
                                                                             150,
                                                                      child: Text(
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .displayName,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(

                                                                              fontSize: 15.0.sp,
                                                                              color: Colors.blueGrey)))),
                                                                  DataCell(Text(
                                                                      snapshot
                                                                          .data[
                                                                              1]
                                                                          .toString(),
                                                                      style: TextStyle(

                                                                          fontSize: 15.0.sp,
                                                                          color:
                                                                          Colors.blueGrey))),
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
                                                      SizedBox(height: 10),
                                                    ])),
                                            )))),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0), child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),// <-- clips to the 200x200 [Container] below
                                            child:BackdropFilter(

                                                filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                                                child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              border: Border.all(
                                                  color: Colors.white,// set border color
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

                                            child:
                                            Column(children: <Widget>[
                                              SizedBox(height: 10),
                                             Container(
                                                  child:  Text(
                                                      'Press to Play',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          fontSize: 20.0.sp,
                                                          color: Colors.lightBlueAccent)),
                                                ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 50.0),
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
                                                    color: Colors.blueGrey,
                                                    onPressed: () => setState(() {
                                                      playGame = true;
                                                      pauseGame = false;
                                                    }),
                                                    child: BlinkText(
                                                      'NUMDASH',
                                                      style: TextStyle(
                                                        fontSize: 20.0.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        color: Colors.white,
                                                      ),
                                                      endColor: Colors.yellow,
                                                    ),
                                                  ),
                                                ),),SizedBox(height: 20),])),

                                        ),
                                        ))])))));
    } else {
      return MaterialApp(

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
