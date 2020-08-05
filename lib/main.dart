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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences storage = await SharedPreferences.getInstance();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  final size = await Flame.util.initialDimensions();
  game = MyGame(size);
  tempWidth = size.width;
  runApp(game.widget);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

double tempX = 0;
double heightPos = 0;
class Test extends TextComponent{
  double speedX = 200.0;
  double posX, posY;
  Test(String text, TextConfig textConfig, double posX, double posY) : super(text) {
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX;
    this.y = posY;
    print("created");
  }

  @override
  void update(double tt){
    if (this.x <0){
     destroy();
    }
    super.update(tt);
    this.x -= speedX * tt;

  }
}
TextConfig comp = TextConfig(color: BasicPalette.white.color);
TextConfig prime = TextConfig(color: Color(0xFFFF00FF));
double tempWidth = 0;

class MyGame extends BaseGame {
  double timerPrime = 0;
  double timerComp = 0;
  Test test;
  var primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149];
  var composites = [4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 22, 24, 25, 26, 27, 28, 30, 32, 33, 34, 35, 36, 38, 39, 40, 42, 44, 45, 46, 48, 49, 50, 51, 52, 54, 55, 56, 57, 58, 60, 62, 63, 64, 65, 66, 68, 69, 70, 72, 74, 75, 76, 77, 78, 80, 81, 82, 84, 85, 86, 87, 88, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 102, 104, 105, 106, 108, 110, 111, 112, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 128, 129, 130, 132, 133, 134, 135, 136, 138, 140, 141, 142, 143, 144, 145, 146, 147, 148, 150];
  var rng;
  MyGame(Size size) {
    this.rng = new Random();
    heightPos = size.height;
    this.timerPrime = Normal.quantile(rng.nextDouble(), mean: 3, variance: 0.7);
    this.timerComp = Normal.quantile(rng.nextDouble(), mean: 3, variance: 0.7);

    print(composites.length);
  }
    @override
    void render(Canvas c) {
      super.render(c);
    }
    @override
    void update(double t) {

      timerPrime -= t;
      timerComp -= t;
      if (timerPrime < 0) {
        double posGem = rng.nextDouble() * heightPos;
        int genInt = rng.nextInt(36);
        add(test = Test(primes[genInt].toString(), comp, tempWidth, posGem));

        timerPrime = Normal.quantile(rng.nextDouble(), mean: 0, variance: 0.7) + 2;
      }
      if (timerComp < 0) {
        double posComp = rng.nextDouble() * heightPos;
        int genInt = rng.nextInt(115);
        add(test = Test(composites[genInt].toString(), prime, tempWidth, posComp));

        timerComp = Normal.quantile(rng.nextDouble(), mean: 0, variance: 0.7) + 2;
      }
      super.update(t);
  }
}