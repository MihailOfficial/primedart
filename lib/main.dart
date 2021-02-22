
import 'package:flutter/material.dart';
import 'package:sizer/sizer_util.dart';
import 'home.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';



void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Flame.util.setPortrait();

  WidgetsFlutterBinding.ensureInitialized();


  //SharedPreferences storage = await SharedPreferences.getInstance();
  count[0] = 0;
  count[1] = 0;
  count[2] = 0;
  count[3] = 0;

  Util flameUtil = Util();

  final size = await Flame.util.initialDimensions();


  TapGestureRecognizer tapper = TapGestureRecognizer();
  flameUtil.addGestureRecognizer(tapper);
  tempWidth = size.width;
  tempHeight = size.height;
  game = MyGame(size);
  runApp(MyApp());


}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return LayoutBuilder(                           //return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(                  //return OrientationBuilder
          builder: (context, orientation) {
        //initialize SizerUtil()
        SizerUtil().init(constraints, orientation);
        return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Onboarding Concept',
      home: Builder(
        builder: (BuildContext context) {

          var screenHeight = MediaQuery.of(context).size.height;

          return
            Home();
        },
      ),
    );
  });
    });
  }
}
