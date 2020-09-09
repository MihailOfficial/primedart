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
class Product extends StatelessWidget {
  static const String routeName = "/product";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(


        centerTitle: true,
        title: Text('Primedash',style: TextStyle(fontFamily: 'logo', fontSize: 30, color: Color.fromRGBO(252,238,10, 1))),

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

    return Material(
      child: Container(
          decoration: new BoxDecoration(color: Color.fromRGBO(252,238,10, 1)),
          child:  Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(

          color: Color.fromRGBO(28, 28, 28, 1),
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),

        // column of three rows
        child: Column(

          // this makes the column height hug its content
          mainAxisSize: MainAxisSize.min,
          children: [

            // first row
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Image(image: AssetImage('assets/images/high.png'), height: 30,
                  ),
                ),
                Text(
                  'WORLD HIGH SCORES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),

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
                  padding: EdgeInsets.only(right: 10.0, left: 20),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
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
                  padding: EdgeInsets.only(right: 10.0, left: 20, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
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
                  padding: EdgeInsets.only(right: 10.0, left: 20, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
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
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15 ),
                  child:Text(
                    '#4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 30, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15),
                  child:Text(
                    '#5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 30, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15),
                  child:Text(
                    '#6',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 30, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15),
                  child:Text(
                    '#7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 30, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 15),
                  child:Text(
                    '#8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 30, top: 15),
                  child:CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    'Mihail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.only(right: 20.0, top: 15),
                  child:Text(
                    '2331',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),),
              ],
            ),


            // third row

          ],
        ),
      )));
    }

}
