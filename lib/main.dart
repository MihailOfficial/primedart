
import 'dart:async';
import 'package:bird/highscore_functions.dart';
import 'package:bird/welcome.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'dataclass.dart';
import 'fader.dart';
import 'game.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool usrCreated;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  usrCreated = await usrExists();
  //SharedPreferences storage = await SharedPreferences.getInstance();
  count[0] = 0;
  count[1] = 0;
  count[2] = 0;
  count[3] = 0;

  Util flameUtil = Util();
  SystemChrome.setEnabledSystemUIOverlays([]);
  final size = await Flame.util.initialDimensions();

  TapGestureRecognizer tapper = TapGestureRecognizer();
  flameUtil.addGestureRecognizer(tapper);
  tempWidth = size.width;
  tempHeight = size.height;
  game = MyGame(size);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('seen') ?? false);
  if (_seen) {
  } else {
    await prefs.setBool('seen', true);
    Data dataInst = new Data();
    dataInst.saveFile("0/0/0/0/0/0");
  }

  runApp(MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor:  Colors.black),
      debugShowCheckedModeBanner: false,
      home: Container (
          decoration: BoxDecoration(),
        child: SplashScreen())));


}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(
              ScaleRoute(page: MyWelcomePage()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      body: Center(
          child: Image.asset('assets/images/splash_logo.png'),
        ),
    );
  }
}
class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool signed = false;
  @override
  @mustCallSuper
  void initState(){
    super.initState();
    signed = usrCreated;
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(

        statusBarColor: Colors.black,
      ),
    );
    if(!signed){
      return Scaffold(
        //this worked
        backgroundColor:Color.fromRGBO(	0, 0, 0, 1),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child:  RegisterEmailSection(signIn: (){
              setState(() {
                signed = true;
              });
            })
        ),
      );
    } else {
      return LayoutBuilder(                           //return LayoutBuilder
          builder: (context, constraints) {
            return OrientationBuilder(                  //return OrientationBuilder
                builder: (context, orientation) {
                  //initialize SizerUtil()
                  SizerUtil().init(constraints, orientation);
                  return Builder(
                    builder: (BuildContext context) {
                      var screenHeight = MediaQuery.of(context).size.height;
                      return Home(

                        signOut: () {
                          //do not use
                        },
                      );
                    },

                  );
                });
          });
    }
  }
}

class MyWelcomePage extends StatefulWidget {



  @override
  _MyWelcomePageState createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {

  bool signed = false;
  bool logged = false;

  @override
  @mustCallSuper
  void initState(){
    super.initState();
    if(FirebaseAuth.instance.currentUser != null) {
      logged = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(

        statusBarColor: Colors.black,
      ),
    );

      return LayoutBuilder(                           //return LayoutBuilder
          builder: (context, constraints) {
            return OrientationBuilder(                  //return OrientationBuilder
                builder: (context, orientation) {
                  //initialize SizerUtil()
                  SizerUtil().init(constraints, orientation);
                  return Builder(
                    builder: (BuildContext context) {
                      var screenHeight = MediaQuery.of(context).size.height;
                      return  Welcomer1();
                    },

                  );
                });
          });
  }
}

