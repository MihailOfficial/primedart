import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

import 'home.dart';
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
import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';

import 'app_drawer.dart';

const COLOR = const Color.fromRGBO(3, 165, 252, 0.5);
const SIZE = 52.0;
const GRAVITY = 200.0;
const BOOST = -150;
var score = 0;
bool updateScore = false;
int highScore = 0;
int changedMultiple = -1;
MyGame game;
double tempHeight = 0;
bool updateLives  =false;
bool hasLives = true;
var x;
var y;
TapDownDetails d;
//Building APK --> flutter build apk --split-per-abi
double height = AppBar().preferredSize.height;
var count = new List(4);

class Home extends StatelessWidget{
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        drawer: AppDrawer(),

      body: SafeArea(
        bottom: false,
        child: Center(
          child: Container(


              child: game.widget,

          ),
        ),
      ),
    );

    }

  }



double tempX = 0;
double heightPos = 0;
int lives = 98;
double orgPos = 0;

class Multiple extends TextComponent{
  Rect pauseRect1;
  double height = AppBar().preferredSize.height;

  static final Paint _paint = Paint()
    ..color = COLOR;
  bool collectedItem = false;
  double speedX = 200.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;

  Multiple(String text, TextConfig textConfig, double posX, double posY) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+45;
    this.y = posY;
    orgPos = this.y;


  }
  @override
  bool destroy() {
    return returned;
  }


  @override
  void update(double tt){
    if (d != null){
      if (pauseRect1.contains(d.globalPosition)){
        print("touched");
        collectedItem = true;

      }}

    if (paused){
      this.x = -20000;
    }
    double dist = 50;
    pauseRect1 = Rect.fromLTWH(this.x-(this.width/2)-7,this.y-(this.height/2),this.width+10,this.height);

    if (collectedItem){
      collectPrime = true;
      TextConfig collected = TextConfig(color: Color( 0xFFFFFF00), fontSize: 35);
      this.config = collected;
      score ++;

      count[0] = (score %10).toInt();
      count[1] = ((score /10) % 10).toInt();
      count[2] = ((score /100) % 10).toInt();
      count[3] = ((score /1000) % 10).toInt();

      updateScore = true;
      collectedItem = false;
    }
    if (this.x <-30 || this.y<0){
      returned = true;
      destroy();

    }
    super.update(tt);

    if (changedMultiple == 1){

      destroy();
     returned = true;
     game.add(new FastMultiple(this.text, this.x, this.y));

    }
    else if (!collectPrime) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y -= 2*accel;

    }
  }
}
class FastMultiple extends TextComponent{
  double height = AppBar().preferredSize.height;

  bool collectedItem = false;
  double speedX = 150.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;
  TextConfig notValid = TextConfig(color: Color.fromRGBO(180, 180, 180 , 1), fontSize: 30);
  FastMultiple(String text, double posX, double posY) : super(text) {
   this.config = notValid;
    this.anchor = Anchor.center;
    this.x = posX;
    this.y = posY;


  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }

    if (this.x <-50 ){
      returned = true;
      destroy();
    }
    accel++;
    super.update(tt);
    this.x -= 4*accel;

  }
}

class NotMultiple extends TextComponent{
  Rect pauseRect2;
  bool collectedItem = false;
  double speedX = 200.0;
  double posX, posY;
  bool collectComp = false;
  double accel = 0;
  bool returned = false;

  NotMultiple(String text, TextConfig textConfig, double posX, double posY) : super(text) {
    pauseRect2 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+45;
    this.y = posY;
    orgPos = this.y;

  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    pauseRect2 = Rect.fromLTWH(this.x-(this.width/2)-7,this.y-(this.height/2),this.width+10,this.height);
    if (paused){
      this.x = -20000;
    }
    if (d != null){
      if (pauseRect2.contains(d.globalPosition)){
        print("touched");
        collectedItem = true;

      }}

    if (collectedItem){
      collectComp = true;
      TextConfig collected = TextConfig(color: Color( 0xFF808080), fontSize: 30);
      this.config = collected;
      if (score>0) {
        lives--;
        score --;
        count[0] = (score %10).toInt();
        count[1] = ((score /10) % 10).toInt();
        count[2] = ((score /100) % 10).toInt();
        count[3] = ((score /1000) % 10).toInt();
        updateLives  =true;
      }
      updateScore = true;
      collectedItem = false;
    }
    if (this.x <-50 || this.y>tempHeight){
      returned = true;
      destroy();

    }

    if (changedMultiple == 1){

      destroy();
      returned = true;
      game.add(new FastMultiple(this.text, this.x, this.y));

    }
    else if(!collectComp) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y += 2*accel;

    }
    super.update(tt);
  }
}


double tempWidth = 0;
String message;
bool specialMessage = false;
bool eliminateScoreFlash = false;
bool spikeDeath = false;
bool frozen = true;

bool paused = false;
double heightApp = AppBar().preferredSize.height;

int tempUpdate = 0;

class MyGame extends BaseGame with TapDetector {
  void onTapDown(TapDownDetails details) {
   d= details;
  }

  double timerPrime = 0;
  double timerComp = 0;
  int currentMultiple = 2;
  Multiple multiple;

  NotMultiple notMultiple;
  var multiples = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var subtrators = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var colours = [
    Color.fromRGBO(247, 220, 111, 1),
    Color.fromRGBO(215, 219, 221, 1),
    Color.fromRGBO(245, 176, 65, 1),
    Color.fromRGBO(88, 214, 141, 1),
    Color.fromRGBO(72, 201, 176, 1),
    Color.fromRGBO(93, 173, 226, 1),
    Color.fromRGBO(236, 112, 99, 1),
    Color.fromRGBO(255, 111, 0, 1)];
  var rng;
  var counter = 0;
  TextPainter textPainterScore;
  TextPainter textPainterLives;
  TextPainter textPainterScoreText;
  TextPainter textPainterLivesText;
  TextPainter textPainterNoMoreLives;
  TextPainter textPainterNumTypeText;
  TextPainter textPainterNumType;
  Offset positionScore;
  Offset positionLives;
  Offset positionScoreText;
  Offset positionLivesText;
  Offset positionNoMoreLives;
  Offset positionNumType;
  Offset positionNumTypeText;
  static List<ParallaxImage> images = [

    ParallaxImage("Nebula Blue.png"),
    ParallaxImage("Stars Small_1.png"),
    ParallaxImage("Stars Small_2.png"),
    ParallaxImage("Stars-Big_1_1_PC.png"),
    ParallaxImage("Stars-Big_1_2_PC.png"),

  ];
  double previousPos = 0.0;
  var yPositions = new List(11);
  final parallaxComponent = ParallaxComponent(images,
      baseSpeed: const Offset(20, 0), layerDelta: const Offset(30, 0));
  MyGame(Size size) {

    add(parallaxComponent);
    add(Bg());
    add(Bottom());




    this.rng = new Random();
    int intTemp = 2;
    for (int i = 0; i<11; i++){
      intTemp++;
      yPositions[i] = ((tempHeight-height)/12)*( intTemp);
    }

    textPainterNoMoreLives = TextPainter(text: TextSpan(
        text: "" ,
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

    textPainterLivesText = TextPainter(text: TextSpan(
        text: "L:",
        style: TextStyle(
            color: Color.fromRGBO(72, 212, 88, 1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLivesText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var te1;
    textPainterNumTypeText = TextPainter(

      text: TextSpan(
        text: "MULTIPLES:",

        style: TextStyle(
            color: Color.fromRGBO(252,238,10, 1), fontSize: 18, fontFamily: "bold")),
        textDirection: TextDirection.ltr,textAlign: TextAlign.center,
          );

    textPainterNumTypeText.layout(
      minWidth: 0,
      maxWidth: tempWidth,

    );

    positionNumTypeText = Offset(size.width *(9.1/20) - textPainterNumTypeText.width / 2,
        heightApp/2 - textPainterNumTypeText.height / 2);

    textPainterNumType = TextPainter(

      text: TextSpan(
          text: "",

          style: TextStyle(
              color: Color(0xFFFF0000), fontSize: 36, fontFamily: "bold")),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center,
    );

    textPainterNumType.layout(
      minWidth: 0,
      maxWidth: tempWidth,

    );

    positionNumType = Offset(size.width *(10.8/20) - textPainterNumType.width / 2,
        heightApp/2 - textPainterNumType.height / 2);

    positionLivesText = Offset(size.width *(1.3/20) - textPainterLivesText.width / 2,
        heightApp/2 - textPainterLivesText.height / 2);

    textPainterLives = TextPainter(text: TextSpan(
        text: lives.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionLives = Offset(size.width *(2.3/20)- textPainterLives.width / 2,
        heightApp/2 - textPainterLives.height / 2);

    textPainterScoreText = TextPainter(text: TextSpan(
        text: "S: " ,
        style: TextStyle(
            color: Color.fromRGBO(255, 46, 46, 1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScoreText = Offset(size.width *(3.5/20) - textPainterScoreText.width / 2,
        heightApp/2 - textPainterScoreText.height / 2);



    textPainterScore = TextPainter(text: TextSpan(
        text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScore.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScore = Offset(size.width *(4.8/20) - textPainterScore.width / 2,
        heightApp/2 - textPainterScore.height / 2);

  }

  static const COLOR = const Color(0xFF527A80);

  @override
  bool recordFps() => true;
  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));
  final Position debugPosition = Position(0, tempHeight -100);

  @override
  void render(Canvas c) {

    super.render(c);
    textPainterScore.paint(c, positionScore);
    textPainterScoreText.paint(c, positionScoreText);
    textPainterLives.paint(c, positionLives);
    textPainterLivesText.paint(c, positionLivesText);
    textPainterNoMoreLives.paint(c, positionNoMoreLives);
    textPainterNumTypeText.paint(c, positionNumTypeText);
    textPainterNumType.paint(c, positionNumType);

  }

  @override
  void update(double t) {
    if (d != null) {
    tempUpdate++;
    }
    if (tempUpdate == 3){
      d=null;
      tempUpdate = 0;
    }
    if (!paused){
    if (changedMultiple >= 0) {
      changedMultiple--;
    }
    counter++;
    if (counter%1600 == 0){
      var rng = new Random();
      currentMultiple = rng.nextInt(5)+2;
      changedMultiple = 1;
    }

    textPainterNumType = TextPainter(text: TextSpan(
        text: currentMultiple.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 36, fontFamily: "bold")),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center,);
    textPainterNumType.layout(
      minWidth: 0,
      maxWidth: tempWidth,
    );

    if (updateLives) {
      textPainterLives = TextPainter(text: TextSpan(
          text: lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );

    }
    if (updateScore) {
      textPainterScore = TextPainter(text: TextSpan(
          text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterScore.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );


      updateScore = false;
    }
   // int genColourComp = rng.nextInt(8);
    TextConfig comp = TextConfig(color: colours[0], fontSize: 40, fontFamily: "fontNum");
   // int genColourPrime = rng.nextInt(5);
    TextConfig primeC = TextConfig(color: colours[1], fontSize: 40, fontFamily: "fontNum");
    if (lives > 0) {
      timerPrime += t;


        if (timerPrime > 0.8) {
          timerPrime = 0;
          d=null;
          int typeNum = rng.nextInt(2);
          double Pos = yPositions[rng.nextInt(10)].toDouble();
          int temp = 0;
          int gen = rng.nextInt(2);


          while (temp == 0) {

            if (previousPos == Pos) {
              Pos = yPositions[rng.nextInt(9)].toDouble();
            }
            else {
              temp++;
              previousPos = Pos;
            }
          }

          if (typeNum == 0) {


            int scalar = rng.nextInt(8)+1;
            int finalScaled = scalar*currentMultiple;

            int secondNum = rng.nextInt(10)+2;

            while (secondNum >= finalScaled) {

              scalar = rng.nextInt(8)+1;
              finalScaled = scalar*currentMultiple;
              secondNum = rng.nextInt(10)+2;
           }

              if (gen == 0) {
                add(multiple = Multiple(
                    (finalScaled-secondNum).toString() + "+" + secondNum.toString(), primeC,
                    tempWidth, Pos));
              }

              else {
              add(multiple = Multiple(
                  (finalScaled+secondNum).toString() + "-" + secondNum.toString(), primeC,
                  tempWidth, Pos));
            }
          }

          if (typeNum == 1) {

            int num = rng.nextInt(40)+2;

            int tempSecond = 0;

            while (num%currentMultiple == 0){
              num= rng.nextInt(40)+2;

            }

            tempSecond = rng.nextInt(10)+2;

            while (tempSecond >= num){

              num = rng.nextInt(40)+2;
             tempSecond = rng.nextInt(10)+2;
           }


            if (gen == 0) {

              add(notMultiple = NotMultiple(
                  (num-tempSecond).toString() + "+" + tempSecond.toString(), comp,
                  tempWidth, Pos));
            }

            else {

              add(notMultiple = NotMultiple(
                  (num+tempSecond).toString() + "-" + tempSecond.toString(), comp,
                  tempWidth, Pos));
            }
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
    }
    }

    super.update(t);
  }



}
class Bg extends Component with Resizable {

  static final Paint _paint = Paint()
    ..color = COLOR;
  @override

  @override
  void render(Canvas c) {
  //  c.drawRect(Rect.fromLTWH(tempWidth*0.375,0, tempWidth*0.22, heightApp), _paint);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth*0.375,0,tempWidth*0.22,heightApp),Radius.circular(600.0)),_paint);

  }

  @override
  void update(double t) {
    // TODO: implement update
  }


}




class Bottom extends Component with Resizable {
  static final Paint _paint = Paint()
    ..color = Color.fromRGBO(22, 22, 22, 0.7);

  @override
  void render(Canvas c) {


  }

  @override
  void update(double t) {

  }
}

