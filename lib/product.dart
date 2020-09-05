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
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Concept',
      home: ScoreScreen()
    );
  }
}

class ScoreScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(


          centerTitle: true,
          title: Text('Primedash', style: TextStyle(fontFamily: 'logo',
              fontSize: 30,
              color: Color.fromRGBO(252, 238, 10, 1))),

          backgroundColor: Color.fromRGBO(28, 28, 28, 1),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Table(

                      children: [
                        TableRow(children: [
                          Text(''),
                          Text('Username:', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('Score:', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),
                        TableRow(children: [
                          Text('#1', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text(names[0], textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('11', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),
                        TableRow(children: [
                          Text('#2', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text(names[1], textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('11', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),
                        TableRow(children: [
                          Text('#3', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text(names[2], textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('11', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),
                        TableRow(children: [
                          Text('#4', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text(names[3], textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('11', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),
                        TableRow(children: [
                          Text('#5', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text(names[4], textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                          Text('11', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                        ]),

                      ],
                    ),
                  ),
                ])));
  }
}
