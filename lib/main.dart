
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer_util.dart';
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


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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


  runApp(MaterialApp(
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
        Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(title: "primedart"))));
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
    if(logged){
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
                              setState(() {
                                signed = true;
                                logged = false;
                                FirebaseAuth.instance.signOut();
                              });
                            },
                          );
                      },

                  );
                });
          });
    } else {
      if(!signed){
        return Scaffold(
          //this worked
          backgroundColor:Color.fromRGBO(	0, 0, 0, 1),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
              child:  RegisterEmailSection(signIn: (){
                setState(() {
                  logged = true;
                });
              })
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Color.fromRGBO(	0, 0,0, 1),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
              child: EmailPasswordForm(
                loggedIn: (){
                  setState(() {
                    logged = true;
                  });
                },
              )
          ),
        );
      }
    }

  }
}
