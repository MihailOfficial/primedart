
import 'package:flutter/material.dart';
import 'package:sizer/sizer_util.dart';
import 'home.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'highscore_functions.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Flame.util.setPortrait();
  await Firebase.initializeApp();
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

    return MaterialApp(
        home: MyHomePage(title: "primedart")
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool signed = false;
  bool logged = false;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if(logged){
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
                          Container (
                          child: Stack(
                            children: <Widget>[
                              Home(),
                              Column(
                              children: <Widget>[

                                  RaisedButton(
                                      child: new Text("Button 1", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                                      color: Colors.red,
                                      //onPressed:
                                  ),

                                  RaisedButton(
                                    child: new Text("Button 2", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                                    color: Colors.red,
                                    onPressed: () async => {
                                      print(await submitScore(250))
                                    }
                                  ),

                                  RaisedButton(
                                    child: new Text("Button 3", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                                    color: Colors.red,
                                    //onPressed:
                                  ),

                                  RaisedButton(
                                    child: new Text("Button 4", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                                    color: Colors.red,
                                    onPressed: () => print("Button press"),
                                  ),

                                  RaisedButton(
                                    child: new Text("Button 5", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                                    color: Colors.red,
                                    //onPressed:
                                  ),

                            ],
                          ),

                            ]));
                      },
                    ),
                  );
                });
          });
    } else {
      if(!signed){
        return Scaffold(

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
        return Scaffold(

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
