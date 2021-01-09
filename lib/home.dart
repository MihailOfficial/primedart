import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:vibration/vibration.dart';
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
import 'package:sizer/sizer.dart';
import 'app_drawer.dart';

const COLOR = const Color.fromRGBO(0,0,0, 0.5);
const COLOR2 = const Color.fromRGBO(26, 22, 92, 1);
const COLOR3 = const Color.fromRGBO(252,238,10, 1);
const COLOR4 = const Color.fromRGBO(0,0,0, 0.3);

var colours = [
  Color.fromRGBO(210, 0, 0, 1),
  Color.fromRGBO(0, 51, 204, 1),
  Color.fromRGBO(0, 153, 51, 1),
  Color.fromRGBO(148,0,211, 1),
  Color.fromRGBO(205, 113, 21, 1)
 ];

const SIZE = 52.0;
const GRAVITY = 200.0;
const BOOST = -150;
var score = 0;
bool updateScore = false;
bool start = false;
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
bool debug = false;
bool globalShrink = false;
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
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
           child: game.widget,


      ),

            /*Padding(
              padding: EdgeInsets.fromLTRB(tempWidth/1.4, heightApp*(6),0, 0),

              child: FlatButton(

                color: Color.fromRGBO(175, 58, 52, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                textColor: Color.fromRGBO(252,238,10, 1),
                onPressed: () {
                debug = true; start = true;},
                child: Text('', style: TextStyle( fontSize: 18, fontFamily: "bold")),
              ),*/


    ]));
    }
  }

double tempX = 0;
double heightPos = 0;
int lives = 98;
var table = List.generate(6, (i) => List(7), growable: false);
var ctable = List.generate(6, (i) => List(7), growable: false);
var dtable = List.generate(6, (i) => List(7), growable: false);





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

  bool rand = false;
  bool fall = true;
  bool shrink = false;
  bool shrinkCollect = false;
  double sizeF = 21.0.sp;
  int genColourComp;
  Paint _paint12;
  int counter = 0;
  Multiple(String text, TextConfig textConfig, double Column, double Row, double top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/8)*Column;
    this.y = 0;
    column = Column;
    row = Row;

    var rng1 = new Random();
    genColourComp = rng1.nextInt(5);
    _paint12 = Paint()
      ..color = colours[genColourComp];
    ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
  }
  @override
  bool destroy() {
    return returned;
  }
bool bottomFall = false;
  @override
  void update(double tt){



    if (fall && !shrink){

      ctable[row.toInt()][(column-1).toInt()] = 0;
      if ((this.y + 10) >= positionArray[row.toInt()]){
          fall = false;
          ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
          table[(row).toInt()][(column-1).toInt()] = true;
          accel = 1;
          this.y =  positionArray[row.toInt()];
        }
      else {
        this.y += 10;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }}



    if (row != 5 && !fall){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;
        table[(row+1).toInt()][(column-1).toInt()] = true;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        rand = true;
        row++;

      }
    }

    if (dtable[(row).toInt()][(column-1).toInt()] == true && !fall && !newDeck) {
      Vibration.vibrate();
      dtable[row.toInt()][(column-1).toInt()] = false;
      this.config = TextConfig(color: Colors.black);
      text = '+1';
      _paint12 = Paint()
        ..color = Color.fromRGBO(255,215,0, 1);

      collectPrime = true;
      shrinkCollect = true;
    }

    if (rand == true){
      if ((this.y+5) <=  positionArray[(row).toInt()]){
        this.y += 5;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        accel++;
      }
      else {
        rand = false;
        accel = 1;
        this.y =  positionArray[row.toInt()];
        ctable[(row).toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
      }
    }

    if (shrink){

      if (sizeF < 0){
        destroy();
        shrink = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        TextConfig comp = TextConfig(color: Colors.white, fontSize: sizeF, fontFamily: "fontNum");
        this.config =comp;
        sizeF -= 2.5;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }

    }

    if (shrinkCollect){
      counter ++;
      if (counter < 40){
        globalShrink = true;
      } else {
        globalShrink = false;
      }

      if (sizeF < 0){
        globalShrink = false;
        destroy();
        shrinkCollect = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        if (counter > 40) {

          TextConfig comp = TextConfig(
              color: Colors.black, fontSize: sizeF, fontFamily: "fontNum");
          this.config = comp;
          sizeF -= 2.5;
          ctable[row.toInt()][(column - 1).toInt()] = 0;
        }
      }

    }

    if (m != null && !shrink && !globalShrink){
      if (pauseRect1.contains(m.globalPosition)){

    Vibration.vibrate();

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
    pauseRect1 = Rect.fromLTWH((tempWidth/8)*column-(tempWidth/18),(this.y-5)-(this.height/2),(tempWidth/18)*2,this.height+10);


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
  bool shrink = false;
  bool rand = false;
  bool fall = true;
  Paint _paint12;
  bool collectPrime = false;
  double sizeF = 21.0.sp;
  int genColourComp;
  int counter = 0;
  bool shrinkCollect = false;
  NotMultiple(String text, TextConfig textConfig, double Column, double Row, double top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/8)*Column;
    this.y = 0;
    column = Column;
    row = Row;

    var rng2 = new Random();
    genColourComp = rng2.nextInt(5);
    _paint12 = Paint()
      ..color = colours[genColourComp];
    ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
  }
  @override
  bool destroy() {
    return returned;
  }
  bool bottomFall = false;
  @override
  void update(double tt){

    if (fall && !shrink){

      ctable[row.toInt()][(column-1).toInt()] = 0;
      if ((this.y + 10) >= positionArray[row.toInt()]){
        fall = false;
        ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
        accel = 1;
        this.y =  positionArray[row.toInt()];
      }
      else {
        this.y += 10;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }}




    if (row != 5 && !fall){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;
        table[(row+1).toInt()][(column-1).toInt()] = true;
        ctable[(row+1).toInt()][(column-1).toInt()] = 0;
        rand = true;
        row++;

      }
    }

    if (dtable[(row).toInt()][(column-1).toInt()] == true && !fall && !newDeck) {
      Vibration.vibrate();
      this.config = TextConfig(color: Colors.black);
      text = '+1';
      dtable[row.toInt()][(column-1).toInt()] = false;
       _paint12 = Paint()
         ..color = Color.fromRGBO(255,215,0, 1);
      collectPrime = true;
      shrinkCollect = true;
    }

    if (rand == true){
      if ((this.y+5) <=  positionArray[(row).toInt()]){
        this.y += 5;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        accel++;
      }
      else {
        rand = false;
        accel = 1;
        this.y =  positionArray[row.toInt()];
        ctable[(row).toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
      }
    }

    if (shrink){
      if (sizeF < 0){

        destroy();
        shrink = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        TextConfig comp = TextConfig(color: Colors.white, fontSize: sizeF, fontFamily: "fontNum");

        this.config =comp;
        sizeF -= 2.5;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }

    }

    if (shrinkCollect){
      counter ++;

      if (counter < 40){
        globalShrink = true;
      } else {
        globalShrink = false;
      }

      if (sizeF < 0){
        globalShrink = false;
        destroy();
        shrinkCollect = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        if (counter > 40) {

          TextConfig comp = TextConfig(
              color: Colors.black, fontSize: sizeF, fontFamily: "fontNum");
          this.config = comp;
          sizeF -= 2.5;
          ctable[row.toInt()][(column - 1).toInt()] = 0;
        }
      }

    }

    if (m != null && !collectNot && !globalShrink){
      if (pauseRect1.contains(m.globalPosition)){
        Vibration.vibrate();
        _paint12 = Paint()
          ..color = Color.fromRGBO(80, 80, 80, 0.9);
        inc++;
        this.config = TextConfig(color: Colors.grey, fontSize: 21.0.sp, fontFamily: "fontNum");
        ctable[row.toInt()][(column-1).toInt()] = 0;

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
    pauseRect1 = Rect.fromLTWH((tempWidth/8)*column-(tempWidth/18),(this.y-5)-(this.height/2),(tempWidth/18)*2,this.height+10);

    if (collectPrime){
      score ++;

      updateScore = true;
      collectPrime = false;
    }
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
var positionArray = new List(6);
class MyGame extends BaseGame with HasTapableComponents {

  @override
  Color backgroundColor() => const Color.fromRGBO(0, 0, 0, 0.4);

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


    for (int a = 0; a<6; a++){
      for (int b = 0; b<7; b++){
        table[a][b] = false;
        ctable[a][b] = 0;
        dtable[a][b] = false;
      }
    }

    positionArray[0] = 2* (tempHeight/8);
    positionArray[1] = 3* (tempHeight/8);
    positionArray[2] = 4* (tempHeight/8);
    positionArray[3] = 5* (tempHeight/8);
    positionArray[4] = 6* (tempHeight/8);
    positionArray[5] = 7* (tempHeight/8);

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
        text: "M:",
        style: TextStyle(
            color: Color.fromRGBO(252,238,10, 1), fontSize: 22, fontFamily: "bold")),
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
            color: Color.fromRGBO(0,0,0, 1), fontSize: 18, fontFamily: "bold")),
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

    positionNumType = Offset(size.width *(10.9/20) - textPainterNumType.width / 2,
        heightApp/2 - textPainterNumType.height / 2);

    positionLivesText = Offset(size.width *(4.9/20) - textPainterLivesText.width / 2,
        heightApp/2 - textPainterLivesText.height / 2);

    textPainterLives = TextPainter(text: TextSpan(
        text: lives.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionLives = Offset(size.width *(5.9/20)- textPainterLives.width / 2,
        heightApp/2 - textPainterLives.height / 2);

    textPainterScoreText = TextPainter(text: TextSpan(
        text: "S: " ,
        style: TextStyle(
            color: Color.fromRGBO(252,238,10,1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScoreText = Offset(size.width *(12.9/20) - textPainterScoreText.width / 2,
        heightApp/2 - textPainterScoreText.height / 2);



    textPainterScore = TextPainter(text: TextSpan(
        text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScore.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScore = Offset(size.width *(14.3/20) - textPainterScore.width / 2,
        heightApp/2 - textPainterScore.height / 2);
    statusBox = tempWidth*0.14;
   updateStatus = tempWidth*0.14/4000;
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
    int secondNum = rng.nextInt(8) + 2;

    while (secondNum >= finalScaled) {
      scalar = rng.nextInt(8) + 1;
      finalScaled = scalar * currentMultiple;
      secondNum = rng.nextInt(8) + 2;
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

    tempSecond = rng.nextInt(8) + 2;

    while (num % currentMultiple == 0 || tempSecond >= num) {
      num = rng.nextInt(40) + 2;
      tempSecond = rng.nextInt(8) + 2;
    }


    if (gen == 0) {
      text = (num - tempSecond).toString() + "+" + tempSecond.toString();
    }
    else {
      text = (num + tempSecond).toString() + "-" + tempSecond.toString();
    }
    return text;
  }
double testInc = 5;

  @override
  void update(double t) {




    for (int c = 5; c >= 0; c--) {
      for (int d = 0; d < 5; d++) {
        if (ctable[c][d] == ctable[c][d+1] && ctable[c][d] == ctable[c][d+2] && ctable[c][d] != 0 && dtable[c][d] == false && dtable[c][d+1] == false && dtable[c][d+2] == false && table[c][d] == true && table[c][d+1] == true && table[c][d+2] == true){


          dtable[c][d] = true;
          dtable[c][d+1] = true;
          dtable[c][d+2] = true;


          ctable[c][d] = 0;
          ctable[c][d+1] = 0;
          ctable[c][d+2] = 0;

      //    game.add(Collected(" +3 ",  (d+1).toDouble(), (c).toDouble()));
        }
      }
    }


      for (int d = 0; d < 7; d++) {
        for (int c = 0; c < 4; c++) {
        if (ctable[c][d] == ctable[c+1][d] && ctable[c][d] == ctable[c+2][d] && ctable[c][d] != 0 && dtable[c][d] == false && dtable[c+1][d] == false && dtable[c+2][d] == false && table[c][d] == true && table[c+1][d] == true && table[c+2][d] == true){


          dtable[c][d] = true;
          dtable[c+1][d] = true;
          dtable[c+2][d] = true;


          ctable[c][d] = 0;
          ctable[c+1][d] = 0;
          ctable[c+2][d] = 0;

       // game.add(Collected(" +3 ",  (d).toDouble(), (c+1).toDouble()));


        }
      }
    }


   /* if (debug){
      print("____________________________");
      for (int a = 0; a<5; a++){
        for (int b = 0; b<6; b++){
          if (ctable[a][b] == 0){
            print(" N ");
          } else if (ctable[a][b] == 1){
            print(" R ");
          } else if (ctable[a][b] == 2){
            print(" B ");
          } else if (ctable[a][b] == 3){
            print(" G ");
          }

        }
        print("___");

      }
      print("____________________________");
      debug = false;

    }*/
    statusBox -= updateStatus;

    if (!paused){
    if (changedMultiple >= 0) {
      changedMultiple--;
    }
    counter++;
    if (counter%4000 == 0){
      var rng = new Random();
      //currentMultiple = rng.nextInt(5)+2;
      changedMultiple = 1;
      newDeck = true;

      statusBox = tempWidth*0.14;
    }

    textPainterNumType = TextPainter(text: TextSpan(
        text: currentMultiple.toString(),
        style: TextStyle(
            color: Color.fromRGBO(26, 22, 92, 1), fontSize: 38, fontFamily: "bold")),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center,);
    textPainterNumType.layout(
      minWidth: 0,
      maxWidth: tempWidth,
    );

    if (updateLives) {
      textPainterLives = TextPainter(text: TextSpan(
          text: lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
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
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
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
    TextConfig mult = TextConfig(color: Colors.white, fontSize: 21.0.sp, fontFamily: "fontNum");
    TextConfig nmult = TextConfig(color: Colors.white, fontSize: 21.0.sp, fontFamily: "fontNum");
    double Pos = 0;

    if (lives > 0) {
      if (newDeck){
        spinNew = true;
        timerPrime += t;
        if (timerPrime > 0.3 ) {



          int genTemp1 = rng.nextInt(2);
          if (genTemp1 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, testInc, 0));
            table[testInc.toInt()][0] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, testInc, 0));
            table[testInc.toInt()][0] = true;
          }

          int genTemp2 = rng.nextInt(2);
          if (genTemp2 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 2, testInc, 0));
            table[testInc.toInt()][1] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, testInc, 0));
            table[testInc.toInt()][1] = true;
          }

          int genTemp3 = rng.nextInt(2);
          if (genTemp3 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 3, testInc, 0));
            table[testInc.toInt()][2] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, testInc, 0));
            table[testInc.toInt()][2] = true;
          }

          int genTemp4 = rng.nextInt(2);
          if (genTemp4 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 4, testInc, 0));
            table[testInc.toInt()][3] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, testInc, 0));
            table[testInc.toInt()][3] = true;
          }

          int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 5, testInc, 0));
            table[testInc.toInt()][4] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, testInc, 0));
            table[testInc.toInt()][4] = true;
          }

          int genTemp6 = rng.nextInt(2);
          if (genTemp6 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 6, testInc, 0));
            table[testInc.toInt()][5] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, testInc, 0));
            table[testInc.toInt()][5] = true;
          }

          int genTemp7 = rng.nextInt(2);
          if (genTemp7 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 7, testInc, 0));
            table[testInc.toInt()][6] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 7, testInc, 0));
            table[testInc.toInt()][6] = true;
          }
          timerPrime = 0;

          testInc --;
        }

        if (testInc < 0){
          newDeck = false;
          spinNew = false;
          timerPrime = 0;
          testInc = 5;
        }
      }

      else if (table[0][0] == false) {

        table[0][0] = true;


        int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, 0, 0));
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, 0, 0));
          }


        }
        else if (table[0][1] == false) {

        table[0][1] = true;


        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 2, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, 0, 0));
        }


        }
        else if (table[0][2] == false) {

        table[0][2] = true;


        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult,3, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, 0, 0));
        }



        } else if (table[0][3] == false) {
        table[0][3] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 4, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, 0, 0));
        }


          }

      else if (table[0][4] == false) {
        table[0][4] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 5, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, 0, 0));
        }

        table[0][4] = true;

      }
      else if (table[0][5] == false) {
        table[0][5] = true;

        int genTemp6 = rng.nextInt(2);
        if (genTemp6 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 6, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, 0, 0));
        }


      }
      else if (table[0][6] == false) {
        table[0][6] = true;

        int genTemp6 = rng.nextInt(2);
        if (genTemp6 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 7, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 7, 0, 0));
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

  static final Paint _paint3 = Paint()
    ..color = COLOR3;
  static final Paint _paint4 = Paint()
    ..color = COLOR4;
  @override

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth/5, heightApp/8, tempWidth*(3/5), heightApp*6/8),Radius.circular(8.0)),_paint2);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth*0.360,heightApp/8,tempWidth*0.235,heightApp*6/8),Radius.circular(0.0)),_paint3);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth*0.388,heightApp/1.45,tempWidth*0.14,heightApp*1/8),Radius.circular(3)),_paint4);
    c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(tempWidth*0.388,heightApp/1.45,statusBox,heightApp*1/8),Radius.circular(3)),_paint);


  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

