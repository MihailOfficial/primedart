import 'package:bird/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

import 'Animation/FadeAnimation.dart';
import 'app_drawer.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboarding/onboarding.dart';
 var names = ["Mihail", "Adam", "Aurko", "Devon", "Jill"];
double statusBarHeight;
class Product extends StatelessWidget {
  static const String routeName = "/product";

  @override
  Widget build(BuildContext context) {
    statusBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(


        centerTitle: true,
        title: Text('LEADERBOARD',style: TextStyle(fontSize: 20, fontFamily: "fontNum", color: Color.fromRGBO(252,238,10, 1))),

        backgroundColor: Color.fromRGBO(28, 28, 28, 1),
      ),
      body: Center(
        child: App(),
      ),
    );
  }
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: ScoreScreen()

      );
  }
}

class ScoreScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
      print("status: " + statusBarHeight.toString());
    return Material(
        child: Container(



            // column of three rows
            child: Column(


            children: [

                  // first row
                 Container(

                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: (MediaQuery.of(context).size.height-statusBarHeight)/3*2,
                                decoration: BoxDecoration(

                                  color: Color.fromRGBO(252, 238, 10, 1),

                                ),
                                child: Column(


                                    children: [
                                    Container(
                                    height: 120,
                                    padding: EdgeInsets.only(left: 30.0, right:30, top:10 ),
                                    child:Container(
                                      decoration: BoxDecoration(

                                        color: Colors.deepOrange,

                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),

                                      padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                                      child: Row(

                                         children: [
                                           Padding(
                                             padding: EdgeInsets.only(left: 8),
                                             child:Text(
                                               '1',

                                               style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 40,
                                               ),
                                             ),
                                           ),
                                           Padding(
                                             padding: EdgeInsets.only(right: 10.0, left: 10),
                                             child:CircleAvatar(
                                               radius: 35,
                                               backgroundImage: AssetImage('assets/images/test.jpg'),
                                             ),
                                           ),
                                      Padding(
                                             padding: EdgeInsets.only(right: 10.0, left: 8),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               textDirection: TextDirection.ltr,
                                               children: [
                                             Padding(
                                             padding: EdgeInsets.only(right: 10.0, top: 12),
                                                 child:
                                                 Text(
                                                   'PLAYER',
                                                   style: TextStyle(
                                                       color: Colors.white70,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 10.0
                                                   ),
                                                 ),),
                                                 Padding(
                                                   padding: EdgeInsets.only(right: 10.0),
                                                   child:
                                                   Text(
                                                     'Adam Jones',
                                                     style: TextStyle(
                                                         color: Colors.white,
                                                         fontWeight: FontWeight.bold,
                                                         fontSize: 20.0
                                                     ),
                                                   ),),

                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(right: 0, top: 6),
                                                      child:Text(
                                                        'PTS',
                                                        style: TextStyle(
                                                            color: Colors.white70,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 10.0
                                                        ),
                                                      ),),
                                                  SizedBox(width: 50),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 0, top: 6),
                                                      child:Text(
                                                        'DATE',
                                                        style: TextStyle(
                                                            color: Colors.white70,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 10.0
                                                        ),
                                                      ),
                                                  ),
                                                ]),
                                                  Container(
                                                    width: 140,

                                                    child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Expanded(
                                                         flex: 2, child:
                                                        Padding(
                                                         padding: EdgeInsets.only(right: 0, top: 0),
                                                         child:Text(
                                                           '7142',
                                                           style: TextStyle(
                                                               color: Colors.white,
                                                               fontWeight: FontWeight.bold,
                                                               fontSize: 20.0
                                                           ),
                                                         ),),
                                                       ),
                                                       Expanded(
                                                         flex: 2, child:
                                                       Padding(
                                                         padding: EdgeInsets.only(right: 0, top: 0),
                                                         child:Text(
                                                           'Jan 22',
                                                           style: TextStyle(
                                                               color: Colors.white,
                                                               fontWeight: FontWeight.bold,
                                                               fontSize: 20.0
                                                           ),
                                                         ),),
                                                       ),
                                                     ]),
                                                  )],

                                              ))

                                          ]
                                           ),




                                       )),
                                      Container(
                                          height: 120,
                                          padding: EdgeInsets.only(left: 30.0, right:30, top:10 ),
                                          child:Container(
                                            decoration: BoxDecoration(

                                              color: Colors.blueAccent,

                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),

                                            padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                                            child: Row(

                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8),
                                                    child:Text(
                                                      '2',

                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10.0, left: 10),
                                                    child:CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage: AssetImage('assets/images/download.jpg'),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(right: 10.0, left: 8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        textDirection: TextDirection.ltr,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 10.0, top: 12),
                                                            child:
                                                            Text(
                                                              'PLAYER',
                                                              style: TextStyle(
                                                                  color: Colors.white70,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 10.0
                                                              ),
                                                            ),),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 10.0),
                                                            child:
                                                            Text(
                                                              'John Jacobs',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 20.0
                                                              ),
                                                            ),),

                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: 0, top: 6),
                                                                  child:Text(
                                                                    'PTS',
                                                                    style: TextStyle(
                                                                        color: Colors.white70,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10.0
                                                                    ),
                                                                  ),),
                                                                SizedBox(width: 50),
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: 0, top: 6),
                                                                  child:Text(
                                                                    'DATE',
                                                                    style: TextStyle(
                                                                        color: Colors.white70,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          Container(
                                                            width: 140,

                                                            child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2, child:
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 0, top: 0),
                                                                    child:Text(
                                                                      '3142',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 20.0
                                                                      ),
                                                                    ),),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2, child:
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 0, top: 0),
                                                                    child:Text(
                                                                      'May 12',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 20.0
                                                                      ),
                                                                    ),),
                                                                  ),
                                                                ]),
                                                          )],

                                                      )),


                                                ]
                                            ),




                                          )),

                                      Container(
                                          height: 120,
                                          padding: EdgeInsets.only(left: 30.0, right:30, top:10 ),
                                          child:Container(
                                            decoration: BoxDecoration(

                                              color: Colors.deepPurple,

                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),

                                            padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                                            child: Row(

                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8),
                                                    child:Text(
                                                      '3',

                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10.0, left: 10),
                                                    child:CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage: AssetImage('assets/images/images.jpg'),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(right: 10.0, left: 8),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        textDirection: TextDirection.ltr,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 10.0, top: 12),
                                                            child:
                                                            Text(
                                                              'PLAYER',
                                                              style: TextStyle(
                                                                  color: Colors.white70,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 10.0
                                                              ),
                                                            ),),
                                                          Padding(
                                                            padding: EdgeInsets.only(right: 10.0),
                                                            child:
                                                            Text(
                                                              'Carlita Levins',
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 20.0
                                                              ),
                                                            ),),

                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: 0, top: 6),
                                                                  child:Text(
                                                                    'PTS',
                                                                    style: TextStyle(
                                                                        color: Colors.white70,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10.0
                                                                    ),
                                                                  ),),
                                                                SizedBox(width: 50),
                                                                Padding(
                                                                  padding: EdgeInsets.only(right: 0, top: 6),
                                                                  child:Text(
                                                                    'DATE',
                                                                    style: TextStyle(
                                                                        color: Colors.white70,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10.0
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                          Container(
                                                            width: 140,

                                                            child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2, child:
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 0, top: 0),
                                                                    child:Text(
                                                                      '714',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 20.0
                                                                      ),
                                                                    ),),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2, child:
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 0, top: 0),
                                                                    child:Text(
                                                                      'Mar 11',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 20.0
                                                                      ),
                                                                    ),),
                                                                  ),
                                                                ]),
                                                          )],

                                                      ))

                                                ]
                                            ),




                                          )),



                            ]),


                            ),

                 ),

]

        )));

  }
}
/*Container(
          decoration: new BoxDecoration(color: Color.fromRGBO(252,238,10, 1)),

        // column of three rows
        child: Column(

          // this makes the column height hug its content
          mainAxisSize: MainAxisSize.min,
          children: [

            // first row
            Row(
              children: [
                  Container(
                    padding: EdgeInsets.only(right: 10.0,left: 12),
                    child:Container(
                  decoration: BoxDecoration(

                    color: Color.fromRGBO(80, 80, 80, 1),
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(15)),

                    ),


                padding: EdgeInsets.only(right: 15, top: 5, left: 12, bottom: 5),

                child:  Row(
                    children: [

                 Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Image(image: AssetImage('assets/images/high.png'), height: 30,
                  ),
                ),

                ),

            Text(
              'Global',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            )

                    ]))),
                Text(
                  'Leaderboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )
              ]),

            // second row (single item)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20,
              ),
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),

            Row(

              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(255, 215, 0, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                      '#1',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),

                  ),),

                Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20),
                  child:Text(
                  'Mihail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),),
                Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(80, 80, 80, 1),
                      border: Border.all(),

                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                      '2331',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),

                  ),),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 15),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(192,192,192, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                      '#2',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),

                  ),),

                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15, left: 20),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Container(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(80, 80, 80, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    ),

                  ),),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 15),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(205,127,50, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                      '#3',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),

                  ),),

                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15, left: 20),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Container(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Container(
                    decoration: BoxDecoration(

                      color: Color.fromRGBO(80, 80, 80, 1),
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),

                    padding: EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),

                    child:Text(
                      '2331',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
download.jpg
images.jpg
*/