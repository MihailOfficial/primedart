
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
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';

const COLOR = const Color(0xff0000ff);
const SIZE = 52.0;
const GRAVITY = 700.0;
const BOOST = -300;
var score = 0;
bool updateScore = false;
int highScore = 0;
int gemCollected = -1;
MyGame game;
double tempHeight = 0;
bool updateLives  =false;
bool hasLives = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences storage = await SharedPreferences.getInstance();


  Util flameUtil = Util();

  final size = await Flame.util.initialDimensions();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  tempWidth = size.width;
  tempHeight = size.height;
  game = MyGame(size);

  runApp(myApp());
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

}
class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      color: Colors.red,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Prime Dart"),
          backgroundColor: Colors.redAccent,
            leading: GestureDetector(
              onTap: () { print("see menu");},
              child: Icon(
                Icons.menu,  // add custom icons also
              ),
            ),
            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {print("see high scores");},
            child: Icon(
              Icons.star_border,
              size: 26.0,
            ),
          )
      ),
        ]),

        body: SafeArea(

          child: Center(
            child: Container(
              child: game.widget,
            ),
          ),
        ),
      ),

    );
  }
}

double tempX = 0;
double heightPos = 0;
int lives = 22;
double orgPos = 0;
class Prime extends TextComponent{

   bool collectedItem = false;
  double speedX = 200.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  Prime(String text, TextConfig textConfig, double posX, double posY, int value) : super(text) {
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+30;
    this.y = posY;
    orgPos = this.y;
    value1 = value;
  }

  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }
    double dist = sqrt((compy-y)*(compy-y) + (compx-x)*(compx-x));

    if (dist<45 && !collectedItem){
      collectPrime = true;
      TextConfig collected = TextConfig(color: Color( 0xFFFFFF00), fontSize: 35);
      this.config = collected;
      score += value1;
      updateScore = true;
      collectedItem = true;
    }
    if (this.x <-30 || this.y<0){
      this.x = -20000;
     destroy();

    }
    super.update(tt);

    if(!collectPrime) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y -= 2*accel;

    }
  }
}

class Composite extends TextComponent{
  bool collectedItem = false;
  double speedX = 200.0;
  double posX, posY;
  bool collectComp = false;
  double accel = 0;

  Composite(String text, TextConfig textConfig, double posX, double posY) : super(text) {
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+30;
    this.y = posY;
    orgPos = this.y;

  }

  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }
    double dist = sqrt((compy-y)*(compy-y) + (compx-x)*(compx-x));

    if (dist<45 && !collectedItem){
      collectComp = true;
      TextConfig collected = TextConfig(color: Color( 0xFF808080), fontSize: 30);
      this.config = collected;
      if (score>0) {
        lives--;
        score --;
        updateLives  =true;
      }
      updateScore = true;
      collectedItem = true;
    }
    if (this.x <-30 || this.y>tempHeight){
      this.x = -20000;
      destroy();

    }
    super.update(tt);

    if(!collectComp) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y += 2*accel;

    }
  }
}


double tempWidth = 0;
String message;
bool specialMessage = false;
bool eliminateScoreFlash = false;
bool spikeDeath = false;
bool frozen = true;
double compx;
double compy;
bool paused = false;
class CharacterSprite extends AnimationComponent with Resizable {
  double speedY = 0.0;

  CharacterSprite()
      : super.sequenced(SIZE/1.5 , SIZE/1.5, 'cat.png', 4,
      textureWidth: 16.0, textureHeight: 16.0) {
    this.anchor = Anchor.center;
    frozen = true;
    paused = true;
  }

  Position get velocity => Position(300.0, speedY);

  reset() {
    this.x = size.width / 4;
    this.y = size.height / 2;

    heightPos = size.height;
    speedY = 0;
    angle = 0.0;
    frozen = true;

  }

  @override
  void resize(Size size) {

    super.resize(size);
    reset();
    frozen = true;
  }


  @override
  void update(double t) {
    if (lives<=0){
      this.x = -20000;
    }
    else {
    super.update(t);
    compx = this.x;
    compy = this.y;
    if (!frozen) {
      this.y += speedY * t; // - GRAVITY * t * t / 2
      this.speedY += GRAVITY * t;
      this.angle = velocity.angle();
      if (y > size.height || y < 0) {
        if (lives > 0) {
          lives--;
        }
        score = 0;
        updateLives  =true;
        updateScore = true;
        paused = true;

        reset();
      }
      if (spikeDeath){

        reset();
      }

    }
  }}

  onTap() {
    paused = false;



    spikeDeath = false;
    if (frozen) {
      frozen = false;
      return;
    }

      speedY = BOOST.toDouble();

  }
}

class MyGame extends BaseGame {


  double timerPrime = 0;
  double timerComp = 0;
  CharacterSprite character;
  Prime prime;
  Composite composite;
  var primes = [
    2,
    3,
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97,
    101,
    103,
    107,
    109,
    113,
    127,
    131,
    137,
    139,
    149
  ];
  var composites = [
    4,
    6,
    8,
    9,
    10,
    12,
    14,
    15,
    16,
    18,
    20,
    21,
    22,
    24,
    25,
    26,
    27,
    28,
    30,
    32,
    33,
    34,
    35,
    36,
    38,
    39,
    40,
    42,
    44,
    45,
    46,
    48,
    49,
    50,
    51,
    52,
    54,
    55,
    56,
    57,
    58,
    60,
    62,
    63,
    64,
    65,
    66,
    68,
    69,
    70,
    72,
    74,
    75,
    76,
    77,
    78,
    80,
    81,
    82,
    84,
    85,
    86,
    87,
    88,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    98,
    99,
    100,
    102,
    104,
    105,
    106,
    108,
    110,
    111,
    112,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    128,
    129,
    130,
    132,
    133,
    134,
    135,
    136,
    138,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    150
  ];
  var subtrators = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  var rng;

  TextPainter textPainterScore;
  TextPainter textPainterLives;
  TextPainter textPainterNoMoreLives;
  Offset positionScore;
  Offset positionLives;
  Offset positionNoMoreLives;

  MyGame(Size size) {
    add(character = CharacterSprite());
    this.rng = new Random();

    textPainterNoMoreLives = TextPainter(text: TextSpan(
        text: "",
        style: TextStyle(
            color: Color(0xFFFF0000), fontSize: 32)),
        textDirection: TextDirection.ltr);
    textPainterNoMoreLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionNoMoreLives =
        Offset(size.width / 2 - textPainterNoMoreLives.width / 2,
            size.height / 2 - textPainterNoMoreLives.height / 2);

    textPainterLives = TextPainter(text: TextSpan(
        text: "Lives: " + lives.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 26)),
        textDirection: TextDirection.ltr);
    textPainterLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionLives = Offset(size.width / 4 - textPainterLives.width / 2,
        size.height * 0.03 - textPainterLives.height / 2);


    textPainterScore = TextPainter(text: TextSpan(
        text: "Score: " + score.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 26)),
        textDirection: TextDirection.ltr);
    textPainterScore.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScore = Offset(size.width * (3 / 4) - textPainterScore.width / 2,
        size.height * 0.03 - textPainterScore.height / 2);
  }

  static const COLOR = const Color(0xFF527A80);

  @override
  void render(Canvas c) {
    final Paint _paint = Paint()
      ..color = COLOR;
    c.drawRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height), _paint);
    super.render(c);

    textPainterScore.paint(c, positionScore);
    textPainterLives.paint(c, positionLives);
    textPainterNoMoreLives.paint(c, positionNoMoreLives);
  }

  @override
  void update(double t) {
    if (updateLives) {
      textPainterLives = TextPainter(text: TextSpan(
          text: "Lives: " + lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 26)),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );

      updateLives = false;
    }
    if (updateScore) {
      textPainterScore = TextPainter(text: TextSpan(
          text: "Score: " + score.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 26)),
          textDirection: TextDirection.ltr);
      textPainterScore.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );

      updateScore = false;
    }
    TextConfig comp = TextConfig(color: BasicPalette.white.color, fontSize: 26);
    TextConfig primeC = TextConfig(
        color: BasicPalette.white.color, fontSize: 26);
    if (lives > 0) {
      timerPrime -= t;
      timerComp -= t;

      if (!paused) {
        if (timerPrime < 0) {
          double posGem = rng.nextDouble() * heightPos;
          if ((posGem - orgPos) < 30) {
            posGem -= 40;
          }
          if ((orgPos - posGem) < 30) {
            posGem += 40;
          }
          if (posGem > 60 && posGem < (heightPos - 60)) {
            int gen = rng.nextInt(3);
            if (gen == 0) {
              add(prime = Prime(
                  primes[rng.nextInt(35)].toString(), comp, tempWidth, posGem,
                  2));
            }
            else if (gen == 1) {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempPrime;
              while (tempLoop == 0) {
                tempPrime = primes[rng.nextInt(35)];
                if (tempPrime > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempPrime = primes[rng.nextInt(35)];
                }
              }

              int finalnum = tempPrime + tempGenNum;
              add(prime = Prime(
                  finalnum.toString() + "-" + tempGenNum.toString(), comp,
                  tempWidth, posGem, 2));
            }

            else {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempPrime;
              while (tempLoop == 0) {
                tempPrime = primes[rng.nextInt(35)];
                if (tempPrime > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempPrime = primes[rng.nextInt(35)];
                }
              }

              int finalnum = tempPrime - tempGenNum;
              add(prime = Prime(
                  finalnum.toString() + "+" + tempGenNum.toString(), comp,
                  tempWidth, posGem, 2));
            }
          }

          timerPrime = 1;
        }

        if (timerComp < 0) {
          double posGem = rng.nextDouble() * heightPos;
          if ((posGem - orgPos) < 30) {
            posGem -= 40;
          }
          if ((orgPos - posGem) < 30) {
            posGem += 40;
          }
          if (posGem > 60 && posGem < (heightPos - 60)) {
            int gen = rng.nextInt(3);
            if (gen == 0) {
              add(composite = Composite(
                  composites[rng.nextInt(35)].toString(), comp, tempWidth,
                  posGem));
            }
            else if (gen == 1) {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempComp;
              while (tempLoop == 0) {
                tempComp = composites[rng.nextInt(35)];
                if (tempComp > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempComp = composites[rng.nextInt(35)];
                }
              }

              int finalnum = tempComp + tempGenNum;
              add(composite = Composite(
                  finalnum.toString() + "-" + tempGenNum.toString(), comp,
                  tempWidth, posGem));
            }

            else {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempComp;
              while (tempLoop == 0) {
                tempComp = composites[rng.nextInt(35)];
                if (tempComp > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempComp = composites[rng.nextInt(35)];
                }
              }

              int finalnum = tempComp - tempGenNum;
              add(composite = Composite(
                  finalnum.toString() + "+" + tempGenNum.toString(), comp,
                  tempWidth, posGem));
            }
          }
          timerComp = 0.8;
        }
      }
    }
    else {
      textPainterNoMoreLives = TextPainter(text: TextSpan(
          text: "Out of lives",
          style: TextStyle(
              color: Color(0xFFFF0000), fontSize: 32)),
          textDirection: TextDirection.ltr);
      textPainterNoMoreLives.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      positionNoMoreLives =
          Offset(size.width / 2 - textPainterScore.width / 2,
              size.height / 2 - textPainterScore.height / 2);
    } super.update(t);
  }


  @override
  void onTapDown(TapDownDetails d) {
    character.onTap();
  }
}



