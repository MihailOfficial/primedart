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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences storage = await SharedPreferences.getInstance();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  final size = await Flame.util.initialDimensions();
  game = MyGame(size);

  runApp(game.widget);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

double tempX = 0;
class Test extends TextComponent with Resizable{
  double speedX = 200.0;

  Test(String text, TextConfig textConfig) : super(text) {
    this.config = textConfig;

    this.y = 200;
  }

  void resize(Size size) {
    super.resize(size);
    this.x = size.width;
    this.y = 200;
  }

  @override
  void update(double t){
    this.x -= 2;
    super.update(t);
  }
}
class MyGame extends BaseGame {

  Test test;

  MyGame(Size size) {
    TextConfig regular = TextConfig(color: BasicPalette.white.color);
    add(test = Test('PrimeDart', regular));

    @override
    void render(Canvas c) {
      super.render(c);
    }
  }
}

