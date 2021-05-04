import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';
import 'main.dart';
import 'game.dart';
class StatsPage extends StatefulWidget {

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
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
                    color: Color.fromRGBO(0, 0, 0, 0.3),
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
                                          const EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[

                                                    Container(
                                                      child: Text(
                                                          'Your stats',
                                                          style: TextStyle(
                                                              fontSize: 25.0.sp,
                                                              fontFamily:
                                                              "sansSar",
                                                              color: Colors
                                                                  .lightBlueAccent)),
                                                    ),
                                                    ClipOval(
                                                      child: Material(
                                                        color: Color.fromRGBO(50, 50, 50, 1),
                                                        // button color
                                                        child: InkWell(
                                                          splashColor: Colors.yellow,
                                                          // inkwell color
                                                          child: SizedBox(
                                                            width: 35,
                                                            height: 35,
                                                            child: Icon(
                                                              Icons.arrow_back_ios_sharp,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          onTap: () => setState(() {

                                                            Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type: PageTransitionType.leftToRight,
                                                                  child: Home(),
                                                                  inheritTheme: true,
                                                                  ctx: context),
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
                                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non lobortis massa. Aliquam et sagittis tortor. Pellentesque risus ligula, maximus in diam at, tempus pulvinar turpis. Ut sagittis felis enim, ac fermentum ipsum auctor quis. Vestibulum eget ligula vestibulum, efficitur quam porta, fermentum erat. ',
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

                    ])))));

  }
}

