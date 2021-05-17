import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'dataclass.dart';
import 'home.dart';
import 'main.dart';
import 'game.dart';
import 'login.dart';

class HowTo extends StatefulWidget {
  @override
  _HotToState createState() => _HotToState();
}

class _HotToState extends State<HowTo> {
  bool playGame = false;
  bool changeUser = false;

  @override
  Widget build(BuildContext context) {
    if (changeUser) {
      return Material(
          child: Scaffold(
        //this worked
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: RegisterEmailSection(signIn: () {
          setState(() {
            changeUser = false;
          });
        })),
      ));
    } else {
      var screenHeight = MediaQuery.of(context).size.height;
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      Data dataInst = new Data();
      dataInst.readFile();
      Future<List<String>> values = dataInst.readFile();
      print("crossed");

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
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text('How To Play',
                                                            style: TextStyle(
                                                                fontSize: 25.0.sp,
                                                                fontFamily: "sansSar",
                                                                color: Colors
                                                                    .lightBlueAccent)),
                                                      ),
                                                      ClipOval(
                                                        child: Material(
                                                          color: Color.fromRGBO(
                                                              50, 50, 50, 1),
                                                          // button color
                                                          child: InkWell(
                                                            splashColor: Colors.yellow,
                                                            // inkwell color
                                                            child: SizedBox(
                                                              width: 35,
                                                              height: 35,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_back_ios_sharp,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            onTap: () => setState(() {
                                                              pauseGame = false;
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => Game(tempt: online)),

                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                      ),
                                                    ])),
                                            SizedBox(height: 10),
                                            Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Container(
                                                  child: Text(
                                                      'Connect 3 of the same coloured tile in a row/column to get 12 points. Touching multiples of the number shown at the top awards 1 point and removes the tile. Touching an incorrect multiple is penalized by 6 points and the tile becomes grey (unmatchable). After 20 seconds, all the tiles are removed, the multiple is changed and new tiles appear.',
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

                            ])),
                      ),
                    ));
    }
  }
}
