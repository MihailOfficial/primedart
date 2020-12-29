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

const COLOR = const Color.fromRGBO(0, 0, 0, 0.3);
const COLOR2 = const Color.fromRGBO(175, 58, 52, 1);
const COLOR3 = const Color.fromRGBO(255, 255, 255, 1);

var colours = [
  Color.fromRGBO(230, 0, 0, 0.8),
  Color.fromRGBO(0, 51, 204, 0.8),
  Color.fromRGBO(0, 153, 51, 0.8)
 ];

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
double statusWidth = 200;
bool style = false;
bool newDeck = true;
bool spinNew = false;
var x;
var y;

//Building APK --> flutter build apk --split-per-abi
double height = AppBar().preferredSize.height;
var count = new List(4);

class Home extends StatelessWidget{
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return
      Scaffold(
        drawer: AppDrawer(),
    body:
      Stack(
          children: <Widget>[
      Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/flowertown.gif"),
                  fit: BoxFit.cover)
          ),
           child: game.widget,


      ),
    Padding(
    padding: EdgeInsets.fromLTRB(tempWidth/2.4, heightApp*(6),0, 0),
    child: FlatButton(

              color: Color.fromRGBO(175, 58, 52, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              textColor: Color.fromRGBO(252,238,10, 1),
    onPressed: () {if (!spinNew){changedMultiple = 2;
    newDeck = true;}},
    child: Text(' SPIN NEW ', style: TextStyle( fontSize: 18, fontFamily: "bold")),
    ),

    ),
    ]));
    }
  }

double tempX = 0;
double heightPos = 0;
int lives = 98;
var table = List.generate(5, (i) => List(6), growable: false);




class Multiple extends TextComponent with Tapable{

  Rect pauseRect1;
  TapDownDetails m;
  double height = AppBar().preferredSize.height;
  void onTapDown(TapDownDetails details) {

    m= details;
  }
  static final Paint _paint = Paint()
    ..color = COLOR;
  bool collectedItem = false;
  double speedX = 100.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 1;
  int value1 = 0;
  bool returned = false;
  double column;
  double row;
  bool topV;
  bool rand = false;
  bool fall = true;
  bool shrink = false;
  double sizeF = 35;
  int genColourComp;
  Paint _paint12;
  Multiple(String text, TextConfig textConfig, double Column, double Row, bool top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/7)*Column;
    this.y = 0;
    column = Column;
    row = Row;
    topV = top;
    var rng1 = new Random();
    genColourComp = rng1.nextInt(3);
    _paint12 = Paint()
      ..color = colours[genColourComp];

    if (top == true){
    table[0][(Column-1).toInt()] = false;


    }
  }
  @override
  bool destroy() {
    return returned;
  }
bool bottomFall = false;
  @override
  void update(double tt){
    if (fall && !shrink){
      this.y += 10;
      accel++;

      if (this.y > positionArray[row.toInt()]){
          fall = false;
          accel = 1;
        }
    }


  if (rand == true && !shrink){

    if (this.y <=  positionArray[(row).toInt()]){
      this.y += 5;
      accel++;
    }
    else {
      rand = false;
      accel = 1;
      this.y += 5;

      table[(row).toInt()][(column-1).toInt()] == true;
    }


  }

    if (row != 4 && !shrink){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;


        rand = true;
        row++;

      }
    }

    if (shrink){
      if (sizeF < 0){
        destroy();
        shrink = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
      }

      else{
        TextConfig comp = TextConfig(color: Colors.white, fontSize: sizeF, fontFamily: "fontNum");
        this.config =comp;
        sizeF -= 3;
      }

    }

    if (m != null && !shrink){
      if (pauseRect1.contains(m.globalPosition)){
        print("touched");
        shrink = true;
        collectPrime = true;

      }}

    if (collectPrime){
      score ++;

      updateScore = true;
      collectPrime = false;
    }
    if (paused){
      this.x = -20000;
    }
    double dist = 50;
    pauseRect1 = Rect.fromLTWH((tempWidth/7)*column-50,this.y-(this.height/2),100,this.height);


    //if (this.x <-30 || this.y<0){
     // returned = true;
     // destroy();

    //}
    super.update(tt);

    if (changedMultiple == 1){

     destroy();
     returned = true;
     game.add(new FastMultiple(this.text, this.x, this.y));

    }


  }

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius((pauseRect1),Radius.circular(8.0)),_paint12);
    super.render(c);

  }
}


class NotMultiple extends TextComponent with Tapable{

  Rect pauseRect1;
  TapDownDetails m;
  double height = AppBar().preferredSize.height;
  void onTapDown(TapDownDetails details) {

    m= details;
  }
  static final Paint _paint = Paint()
    ..color = COLOR;
  bool collectedItem = false;
  double speedX = 100.0;
  double posX, posY;
  bool collectNot = false;
  double accel = 1;
  int value1 = 0;
  int inc = 0;
  bool returned = false;
  double column;
  double row;
  bool topV;
  bool rand = false;
  bool fall = true;
  Paint _paint12;
  int genColourComp;
  NotMultiple(String text, TextConfig textConfig, double Column, double Row, bool top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/7)*Column;
    this.y = 0;
    column = Column;
    row = Row;
    topV = top;
    var rng2 = new Random();
    genColourComp = rng2.nextInt(3);
    _paint12 = Paint()
      ..color = colours[genColourComp];
    if (top == true){
      table[0][(Column-1).toInt()] = false;}
  }
  @override
  bool destroy() {
    return returned;
  }
  bool bottomFall = false;
  @override
  void update(double tt){
    if (fall){
      this.y += 10;
      accel++;

      if (this.y > positionArray[row.toInt()]){
        fall = false;
        accel = 1;
      }
    }



    if (rand == true){
      if (this.y <=  positionArray[(row).toInt()]){
        this.y += 5;
        accel++;
      }
      else {
        rand = false;
        accel = 1;
        this.y += 5;
      }
    }

    if (row != 4){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;
        table[(row+1).toInt()][(column-1).toInt()] == true;

        rand = true;
        row++;

      }
    }

    if (m != null && !collectNot){
      if (pauseRect1.contains(m.globalPosition)){
        _paint12 = Paint()
          ..color = Color.fromRGBO(80, 80, 80, 0.9);
        inc++;
        this.config = TextConfig(color: Colors.grey, fontSize: 35, fontFamily: "fontNum");;
        text = 'X';

      }}
    if (inc == 1){
      if (score>0) {
        score --;

      }
      updateScore = true;

    }
    if (paused){
      this.x = -20000;
    }
    double dist = 50;
    pauseRect1 = Rect.fromLTWH((tempWidth/7)*column-50,this.y-(this.height/2),100,this.height);


    //if (this.x <-30 || this.y<0){
    // returned = true;
    // destroy();

    //}
    super.update(tt);

    if (changedMultiple == 1){

      destroy();
      returned = true;
      game.add(new FastMultiple(this.text, this.x, this.y));

    }


  }

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius((pauseRect1),Radius.circular(8.0)),_paint12);
    super.render(c);

  }}


double updateStatus = 0;
class FastMultiple extends TextComponent{
  double height = AppBar().preferredSize.height;

  bool collectedItem = false;
  double speedX = 150.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;
  TextConfig notValid = TextConfig(color: Colors.grey, fontSize: 35, fontFamily: "fontNum");
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
    this.x -= 2*accel;

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
double statusBox = 0;
int currentMultiple = 2;
var positionArray = new List(5);
class MyGame extends BaseGame with HasTapableComponents {

  @override
  Color backgroundColor() => const Color.fromRGBO(0, 0, 0, 0.6);

  double timerPrime = 0;
  double timerComp = 0;

  Multiple multiple;

  NotMultiple notMultiple;
  var multiples = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var subtrators = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];


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

  var count1 = new List(4);

  var count2 = new List(6);

  double previousPos = 0.0;
  var yPositions = new List(8);






  MyGame(Size size) {



    table[0][0] = false;
    table[0][1] = false;
    table[0][2] = false;
    table[0][3] = false;
    table[0][4] = false;
    table[0][5] = false;

    table[1][0] = false;
    table[1][1] = false;
    table[1][2] = false;
    table[1][3] = false;
    table[1][4] = false;
    table[1][5] = false;

    table[2][0] = false;
    table[2][1] = false;
    table[2][2] = false;
    table[2][3] = false;
    table[2][4] = false;
    table[2][5] = false;

    table[3][0] = false;
    table[3][1] = false;
    table[3][2] = false;
    table[3][3] = false;
    table[3][4] = false;
    table[3][5] = false;

    table[4][0] = false;
    table[4][1] = false;
    table[4][2] = false;
    table[4][3] = false;
    table[4][4] = false;
    table[4][5] = false;

    positionArray[0] = 90;
    positionArray[1] = 140;
    positionArray[2] = 190;
    positionArray[3] = 240;
    positionArray[4] = 290;

    add(Bg());



    for (int i = 0; i<3; i++){
      yPositions[i] = ((tempWidth)/3)*(i+1);
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

    positionLivesText = Offset(size.width *(5.7/20) - textPainterLivesText.width / 2,
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
    positionLives = Offset(size.width *(6.4/20)- textPainterLives.width / 2,
        heightApp/2 - textPainterLives.height / 2);

    textPainterScoreText = TextPainter(text: TextSpan(
        text: "S: " ,
        style: TextStyle(
            color: Color.fromRGBO(255, 120, 120,1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScoreText = Offset(size.width *(12.8/20) - textPainterScoreText.width / 2,
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
    positionScore = Offset(size.width *(13.8/20) - textPainterScore.width / 2,
        heightApp/2 - textPainterScore.height / 2);
    statusBox = tempWidth*0.22;
   updateStatus = tempWidth*0.22/2000;
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

  var rng = new Random();
  String generateMultiple (){

    int gen = rng.nextInt(2);
    String text;

    int scalar = rng.nextInt(8) + 1;
    int finalScaled = scalar * currentMultiple;
    int secondNum = rng.nextInt(10) + 2;

    while (secondNum >= finalScaled) {
      scalar = rng.nextInt(8) + 1;
      finalScaled = scalar * currentMultiple;
      secondNum = rng.nextInt(10) + 2;
    }

    if (gen == 0) {
      text = (finalScaled - secondNum).toString() + "+" + secondNum.toString();
    }

    else {
      text = (finalScaled + secondNum).toString() + "-" + secondNum.toString();

    }
    return text;
  }

  String generateNotMultiple (){

    String text;

    int gen = rng.nextInt(2);
    int num = rng.nextInt(40) + 2;
    int tempSecond = 0;

    while (num % currentMultiple == 0) {
      num = rng.nextInt(40) + 2;
    }

    tempSecond = rng.nextInt(10) + 2;

    while (tempSecond >= num) {
      num = rng.nextInt(40) + 2;
      tempSecond = rng.nextInt(10) + 2;
    }


    if (gen == 0) {
      text = (num - tempSecond).toString() + "+" + tempSecond.toString();
    }
    else {
      text = (num + tempSecond).toString() + "-" + tempSecond.toString();
    }
    return text;
  }
double testInc = 4;
  @override
  void update(double t) {

    statusBox -= updateStatus;

    if (!paused){
    if (changedMultiple >= 0) {
      changedMultiple--;
    }
    counter++;
    if (counter%2000 == 0){
      var rng = new Random();
      currentMultiple = rng.nextInt(5)+2;
      changedMultiple = 1;
      newDeck = true;
      statusBox = tempWidth*0.22;
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

      count[0] = (score %10).toInt();
      count[1] = ((score /10) % 10).toInt();
      count[2] = ((score /100) % 10).toInt();
      count[3] = ((score /1000) % 10).toInt();

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
    //int genColourComp = rng.nextInt(8);
  //  TextConfig comp = TextConfig(color: colours[genColourComp], fontSize: 40, fontFamily: "fontNum");
   // int genColourPrime = rng.nextInt(5);

  //  TextConfig primeC = TextConfig(color: colours[genColourPrime], fontSize: 40, fontFamily: "fontNum");
    TextConfig mult = TextConfig(color: Colors.white, fontSize: 35, fontFamily: "fontNum");
    TextConfig nmult = TextConfig(color: Colors.white, fontSize: 35, fontFamily: "fontNum");
    double Pos = 0;

    if (lives > 0) {
      if (newDeck){
        spinNew = true;
        timerPrime += t;
        if (timerPrime > 0.3 ) {



          int genTemp1 = rng.nextInt(2);
          if (genTemp1 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, testInc, false));
            table[testInc.toInt()][0] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, testInc, false));
            table[testInc.toInt()][0] = true;
          }

          int genTemp2 = rng.nextInt(2);
          if (genTemp2 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 2, testInc, false));
            table[testInc.toInt()][1] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, testInc, false));
            table[testInc.toInt()][1] = true;
          }

          int genTemp3 = rng.nextInt(2);
          if (genTemp3 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 3, testInc, false));
            table[testInc.toInt()][2] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, testInc, false));
            table[testInc.toInt()][2] = true;
          }

          int genTemp4 = rng.nextInt(2);
          if (genTemp4 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 4, testInc, false));
            table[testInc.toInt()][3] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, testInc, false));
            table[testInc.toInt()][3] = true;
          }

          int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 5, testInc, false));
            table[testInc.toInt()][4] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, testInc, false));
            table[testInc.toInt()][4] = true;
          }

          int genTemp6 = rng.nextInt(2);
          if (genTemp6 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 6, testInc, false));
            table[testInc.toInt()][5] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, testInc, false));
            table[testInc.toInt()][5] = true;
          }

          timerPrime = 0;

          testInc --;
        }

        if (testInc < 0){
          newDeck = false;
          spinNew = false;
          timerPrime = 0;
          testInc = 4;
        }
      }

      else if (table[0][0] == false) {

        table[0][0] = true;
        table[1][0] = true;
        table[2][0] = true;
        table[3][0] = true;
        table[4][0] = true;

        int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, 0, false));
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, 0, false));
          }


        }
        else if (table[0][1] == false) {

        table[0][1] = true;
        table[1][1] = true;
        table[2][1] = true;
        table[3][1] = true;
        table[4][1] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 2, 0, false));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, 0, false));
        }


        }
        else if (table[0][2] == false) {

        table[0][2] = true;
        table[1][2] = true;
        table[2][2] = true;
        table[3][2] = true;
        table[4][2] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult,3, 0, false));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, 0, false));
        }



        } else if (table[0][3] == false) {
        table[0][3] = true;
        table[1][3] = true;
        table[2][3] = true;
        table[3][3] = true;
        table[4][3] = true;
        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 4, 0, false));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, 0, false));
        }


          }

      else if (table[0][4] == false) {
        table[0][4] = true;
        table[1][4] = true;
        table[2][4] = true;
        table[3][4] = true;
        table[4][4] = true;
        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 5, 0, false));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, 0, false));
        }

        table[0][4] = true;
        table[1][4] = true;
        table[2][4] = true;
        table[3][4] = true;
        table[4][4] = true;
      }
      else if (table[0][5] == false) {
        table[0][5] = true;
        table[1][5] = true;
        table[2][5] = true;
        table[3][5] = true;
        table[4][5] = true;
        int genTemp6 = rng.nextInt(2);
        if (genTemp6 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 6, 0, false));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, 0, false));
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

    super.update(t);
  }
  }
}

class Bg extends Component with Resizable {

  static final Paint _paint = Paint()
    ..color = COLOR;
  static final Paint _paint2 = Paint()
    ..color = COLOR2;
  @override

  static final Paint _paint3 = Paint()
    ..color = COLOR3;
  @override

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth/4, heightApp/8, tempWidth/2, heightApp*6/8),Radius.circular(8.0)),_paint2);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth*0.375,heightApp/8,statusBox,heightApp*6/8),Radius.circular(0.0)),_paint);

  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

