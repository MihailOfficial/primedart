import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'WidgetChooser.dart';
import 'dataclass.dart';
import 'fader.dart';
import 'home.dart';
import 'login.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  bool playGame = false;
  bool changeUser = false;

  @override
  Widget build(BuildContext context) {
    if (changeUser) {
      return Material(
          child: Scaffold(
        //this worked
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: RegisterEmailSection(signIn: () {
          setState(() {
            changeUser = false;
          });
        })),
      ));
    } else {
      var screenHeight = MediaQuery.of(context).size.height;
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      Data dataInst = new Data();
      dataInst.readFile();
      Future<List<String>> values = dataInst.readFile();
      print("crossed");

      return WidgetChooser(
        condition: screenHeight>650,
        trueChild:  Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                child: ClipOval(
                                  child: Material(
                                    color: Color.fromRGBO(
                                        50, 50, 50, 1),
                                    // button color
                                    child: InkWell(
                                      splashColor:
                                      Colors.yellow,
                                      // inkwell color
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons
                                              .arrow_back_ios_sharp,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      onTap: () =>
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              FadeRoute(
                                                  page: Home()),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30.0),
                                          // <-- clips to the 200x200 [Container] below
                                          child: BackdropFilter(
                                            filter: new ImageFilter.blur(
                                                sigmaX: 20.0, sigmaY: 20.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      // set border color
                                                      width: 1.0),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[
                                                      Color.fromRGBO(250, 250, 250, 0),
                                                      Color.fromRGBO(250, 250, 250, 0)
                                                    ],
                                                  ),
                                                ),
                                                child: Column(children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 30.0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text('Statistics:',
                                                                  style: TextStyle(
                                                                      fontSize: 25.0.sp,
                                                                      fontFamily:
                                                                      "sansSar",
                                                                      color: Colors
                                                                          .lightBlueAccent)),
                                                            ),

                                                          ])),
                                                  SizedBox(height: 20),
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 30.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Highest Score:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                0],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Total Attempts:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                1],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            SizedBox(height: 15),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Multiple Accuracy:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                2] +
                                                                                    "%",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            SizedBox(height: 15),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Matched row/columns:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                3],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        '# multiples touched:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                4],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        '# Non multiples touched:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                5],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                          ])),
                                                  SizedBox(height: 20),
                                                ])),
                                          )))),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    // <-- clips to the 200x200 [Container] below
                                    child: BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 20.0, sigmaY: 20.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(
                                                color: Colors.white,
                                                // set border color
                                                width: 1.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                Color.fromRGBO(60, 60, 60, 0),
                                                Color.fromRGBO(130, 130, 130, 0)
                                              ],
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 10),
                                            Container(
                                              child: Text('Change Username',
                                                  style: TextStyle(
                                                      fontSize: 25.0.sp,
                                                      fontFamily: "sansSar",
                                                      color: Colors.lightBlueAccent)),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 50.0),
                                              child: ButtonTheme(
                                                minWidth: double.infinity,
                                                height: 50.0,
                                                child: MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    /*side: BorderSide(
                              color: Colors.grey,
                              width: 3),*/
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  ),
                                                  color: Color.fromRGBO(100, 152, 176, 1),
                                                  onPressed: () => setState(() {
                                                    changeUser = true;
                                                  }),
                                                  child: Text(
                                                    'EDIT',
                                                    style: TextStyle(
                                                      fontSize: 15.0.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                          ])),
                                    ),
                                  ))
                            ]))))),
        falseChild:  Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                        Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child:
                        Padding(
                                padding: const EdgeInsets.all(11),
                                child: ClipOval(
                                  child: Material(
                                    color: Color.fromRGBO(
                                        50, 50, 50, 1),
                                    // button color
                                    child: InkWell(
                                      splashColor:
                                      Colors.yellow,
                                      // inkwell color
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons
                                              .arrow_back_ios_sharp,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                      onTap: () =>
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              FadeRoute(
                                                  page: Home()),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),),

                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30.0),
                                          // <-- clips to the 200x200 [Container] below
                                          child: BackdropFilter(
                                            filter: new ImageFilter.blur(
                                                sigmaX: 20.0, sigmaY: 20.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      // set border color
                                                      width: 1.0),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[
                                                      Color.fromRGBO(250, 250, 250, 0),
                                                      Color.fromRGBO(250, 250, 250, 0)
                                                    ],
                                                  ),
                                                ),
                                                child: Column(children: <Widget>[
                                                  SizedBox(height: 10),
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 30.0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text('Statistics:',
                                                                  style: TextStyle(
                                                                      fontSize: 25.0.sp,
                                                                      fontFamily:
                                                                      "sansSar",
                                                                      color: Colors
                                                                          .lightBlueAccent)),
                                                            ),

                                                          ])),
                                                  SizedBox(height: 15),
                                                  Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 30.0),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Highest Score:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                0],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Total Attempts:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                1],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            SizedBox(height: 10),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Multiple Accuracy:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                2] +
                                                                                    "%",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            SizedBox(height: 10),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        'Matched row/columns:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                3],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        '# multiples touched:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                4],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                            Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                    child: Text(
                                                                        '# Non multiples touched:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            18.0.sp,
                                                                            fontFamily:
                                                                            "sansSar",
                                                                            color: Color.fromRGBO(100, 152, 176, 1))),
                                                                  ),
                                                                  FutureBuilder(
                                                                      future:
                                                                      Future.wait([
                                                                        values,
                                                                        dataInst
                                                                            .readFile()
                                                                      ]),
                                                                      builder: (BuildContext
                                                                      context,
                                                                          AsyncSnapshot<
                                                                              List>
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            child: Text(
                                                                                dataInst.arr[
                                                                                5],
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style:
                                                                                TextStyle(
                                                                                    fontSize:
                                                                                    18.0.sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color: Color.fromRGBO(100, 152, 176, 1)
                                                                                )),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          print("alert");
                                                                          print(snapshot
                                                                              .error);
                                                                          return CircularProgressIndicator();
                                                                        } else {
                                                                          return Container(
                                                                            child: Text(
                                                                                "_",
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                                style: TextStyle(
                                                                                    fontSize: 18.0
                                                                                        .sp,
                                                                                    fontFamily:
                                                                                    "sansSar",
                                                                                    color:
                                                                                    Color.fromRGBO(100, 152, 176, 1))),
                                                                          );
                                                                        }
                                                                      }),
                                                                ]),
                                                          ])),
                                                  SizedBox(height: 15),
                                                ])),
                                          )))),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    // <-- clips to the 200x200 [Container] below
                                    child: BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 20.0, sigmaY: 20.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                            border: Border.all(
                                                color: Colors.white,
                                                // set border color
                                                width: 1.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                Color.fromRGBO(60, 60, 60, 0),
                                                Color.fromRGBO(130, 130, 130, 0)
                                              ],
                                            ),
                                          ),
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 10),
                                            Container(
                                              child: Text('Change Username',
                                                  style: TextStyle(
                                                      fontSize: 25.0.sp,
                                                      fontFamily: "sansSar",
                                                      color: Colors.lightBlueAccent)),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 50.0),
                                              child: ButtonTheme(
                                                minWidth: double.infinity,
                                                height: 40.0,
                                                child: MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    /*side: BorderSide(
                              color: Colors.grey,
                              width: 3),*/
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  ),
                                                  color: Color.fromRGBO(100, 152, 176, 1),
                                                  onPressed: () => setState(() {
                                                    changeUser = true;
                                                  }),
                                                  child: Text(
                                                    'EDIT',
                                                    style: TextStyle(
                                                      fontSize: 15.0.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ])),
                                    ),
                                  ))
                            ]))))),
      );

    }
  }
}
