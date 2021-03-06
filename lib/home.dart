import 'dart:ui';
import 'package:bird/statspage.dart';
import 'package:bird/welcome.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'WidgetChooser.dart';
import 'fader.dart';
import 'highscore_functions.dart';
import 'game.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;

  Home({@required this.signOut});

  @override
  _HomeState createState() => _HomeState(signOut: signOut);
}

class _HomeState extends State<Home> {
  static const String routeName = "/home";
  final VoidCallback signOut;

  _HomeState({@required this.signOut});

  bool playGame = false;
  Future<List<Map<dynamic, dynamic>>> highscores = getHighScores(6);

  @override
  Widget build(BuildContext context) {
    contexts = context;
    var screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return
      WidgetChooser(
        condition: screenHeight>650,
        trueChild: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Container(
                        child: Column(children: <Widget>[
                          Container(
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Stack(

                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child:
                                              ClipOval(

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
                                                                page: Welcomer1()),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Center(
                                            child:
                                            Text('NumDash',
                                                style: TextStyle(
                                                  fontFamily: 'rage',
                                                  fontSize: 28.0.sp,
                                                  color: Colors.yellow,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 3.0,
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                    Shadow(
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 8.0,
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                  ],
                                                )))
                                      ]))),
                          SizedBox(height: 10),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10,
                                      ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            FutureBuilder(
                                                future: getUsername(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      child: Text("Hi, " + snapshot.data,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.0.sp,
                                                          )),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    print("alert");
                                                    print(snapshot.error);
                                                    return CircularProgressIndicator();
                                                  } else {
                                                    return Container(
                                                      child: Text("Hi, _" ,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.0.sp,
                                                          )),
                                                    );
                                                  }
                                                }),
                                          ]),
                                    ),
                                    ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(50, 50, 50, 1),
                                        // button color
                                        child: InkWell(
                                          splashColor: Colors.yellow,
                                          // inkwell color
                                          child: SizedBox(
                                            width: 46,
                                            height: 46,
                                            child: Icon(
                                              Icons.poll_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () => setState(() {
                                            Navigator.push(
                                              context,
                                              FadeRoute(page: StatsPage()),

                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ])),
                          SizedBox(height: 20),
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
                                              borderRadius: BorderRadius.circular(30.0),
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
                                                      MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text('Global Scores',
                                                              style: TextStyle(
                                                                  fontSize: 25.0.sp,
                                                                  fontFamily: "sansSar",
                                                                  color: Colors.lightBlueAccent)),
                                                        ),

                                                        ButtonTheme(
                                                            minWidth: 20.0,
                                                            child: MaterialButton(
                                                                onPressed: () async {
                                                                  setState(() {
                                                                    highscores =
                                                                        getHighScores(6);
                                                                  });
                                                                },
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      10.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons.refresh,
                                                                  color: Colors.white,
                                                                ))),
                                                      ])),

                                              FutureBuilder(
                                                  future: Future.wait([
                                                    highscores,
                                                    getMyScore(),
                                                    getRank(),
                                                    getUsername()
                                                  ]),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<List> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              dividerColor: Color.fromRGBO(
                                                                  0, 0, 0, 0)),
                                                          child: DataTable(
                                                              columnSpacing: 20,
                                                              dataRowHeight: 24,
                                                              columns: <DataColumn>[
                                                                DataColumn(
                                                                  label: Text(
                                                                    '#',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'NAME',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'SCORE',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: <DataRow>[
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                      '1',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                          fontSize: 15.0.sp,
                                                                          color: Color.fromRGBO(100, 152, 176, 1)),
                                                                    )),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [0][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][0][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('2',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            height: 1.2,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [1][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                height: 1.2,
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][1][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            height: 1.2,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('3',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [2][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][2][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('4',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [3][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][3][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('5',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [4][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][4][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('6',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [5][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][5][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),

                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                        snapshot.data[2]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontSize: 15.0.sp,
                                                                            color: Colors.yellow.withOpacity(0.5)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            snapshot.data[3],
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[1].toString(),
                                                                        style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5)))),
                                                                  ],
                                                                ),
                                                              ]));
                                                    } else if (snapshot.hasError) {
                                                      print("alert");
                                                      print(snapshot.error);
                                                      return CircularProgressIndicator();
                                                    } else {
                                                      return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              dividerColor: Color.fromRGBO(
                                                                  0, 0, 0, 0)),
                                                          child: DataTable(
                                                              columnSpacing: 20,
                                                              dataRowHeight: 24,
                                                              columns: <DataColumn>[
                                                                DataColumn(
                                                                  label: Text(
                                                                    '#',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'NAME',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'SCORE',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: <DataRow>[
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                      '1',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                          fontSize: 15.0.sp,
                                                                          color: Color.fromRGBO(100, 152, 176, 1)),
                                                                    )),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('2',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            height: 1.2,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                height: 1.2,
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            height: 1.2,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('3',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('4',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('5',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('6',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),

                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontSize: 15.0.sp,
                                                                            color: Colors.yellow.withOpacity(0.5)))),
                                                                    DataCell(SizedBox(
                                                                        width: 150,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5)))),
                                                                  ],
                                                                ),
                                                              ]));
                                                    }
                                                  }),
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
                                  filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.yellow,
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
                                          child: Text('Press to Play',
                                              style: TextStyle(
                                                  fontSize: 25.0.sp,
                                                  fontFamily: "sansSar",
                                                  color: Colors.lightBlueAccent)),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 50.0),
                                          child: ButtonTheme(
                                            minWidth: double.infinity,
                                            height: 50.0,
                                            child: MaterialButton(
                                              padding: const EdgeInsets.all(10.0),
                                              shape: RoundedRectangleBorder(
                                                /*side: BorderSide(
                              color: Colors.grey,
                              width: 3),*/
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              color: Color.fromRGBO(100, 152, 176, 1),
                                              onPressed: () => setState(() {

                                                Navigator.push(
                                                  context,
                                                  ScaleRoute(page: Game(tempt: true)),
                                                );
                                                pauseGame = false;
                                              }),
                                              child: BlinkText(
                                                '- PLAY -',
                                                style: TextStyle(
                                                  fontSize: 20.0.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                                endColor: Color.fromRGBO(200, 200, 200, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),

                                      ])),
                                ),
                              ))
                        ]))))),
        falseChild: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Container(
                        child: Column(children: <Widget>[
                          Container(
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Stack(

                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(11),
                                              child:
                                              ClipOval(

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
                                                                page: Welcomer1()),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Center(
                                            child:
                                            Text('NumDash',
                                                style: TextStyle(
                                                  fontFamily: 'rage',
                                                  fontSize: 28.0.sp,
                                                  color: Colors.yellow,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 3.0,
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                    Shadow(
                                                      offset: Offset(5.0, 5.0),
                                                      blurRadius: 8.0,
                                                      color: Color.fromRGBO(240, 240, 240, 0.2),
                                                    ),
                                                  ],
                                                )))
                                      ]))),

                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10,
                                      ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            FutureBuilder(
                                                future: getUsername(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      child: Text("Hi, " + snapshot.data,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.0.sp,
                                                          )),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    print("alert");
                                                    print(snapshot.error);
                                                    return CircularProgressIndicator();
                                                  } else {
                                                    return Container(
                                                      child: Text("Hi, _" ,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.0.sp,
                                                          )),
                                                    );
                                                  }
                                                }),
                                          ]),
                                    ),
                                    ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(50, 50, 50, 1),
                                        // button color
                                        child: InkWell(
                                          splashColor: Colors.yellow,
                                          // inkwell color
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Icon(
                                              Icons.poll_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () => setState(() {
                                            Navigator.push(
                                              context,
                                              FadeRoute(page: StatsPage()),

                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ])),
                          SizedBox(height: 10),
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
                                              borderRadius: BorderRadius.circular(30.0),
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
                                                      MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text('Global Scores',
                                                              style: TextStyle(
                                                                  fontSize: 25.0.sp,
                                                                  fontFamily: "sansSar",
                                                                  color: Colors.lightBlueAccent)),
                                                        ),

                                                        ButtonTheme(
                                                            minWidth: 20.0,
                                                            child: MaterialButton(
                                                                onPressed: () async {
                                                                  setState(() {
                                                                    highscores =
                                                                        getHighScores(6);
                                                                  });
                                                                },
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      10.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons.refresh,
                                                                  color: Colors.white,
                                                                ))),
                                                      ])),

                                              FutureBuilder(
                                                  future: Future.wait([
                                                    highscores,
                                                    getMyScore(),
                                                    getRank(),
                                                    getUsername()
                                                  ]),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<List> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              dividerColor: Color.fromRGBO(
                                                                  0, 0, 0, 0)),
                                                          child: DataTable(
                                                              columnSpacing: 16,
                                                              dataRowHeight: 20,
                                                              columns: <DataColumn>[
                                                                DataColumn(
                                                                  label: Text(
                                                                    '#',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'NAME',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'SCORE',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: <DataRow>[
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                      '1',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                          fontSize: 15.0.sp,
                                                                          color: Color.fromRGBO(100, 152, 176, 1)),
                                                                    )),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [0][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][0][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('2',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            height: 1.2,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [1][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                height: 1.2,
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][1][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            height: 1.2,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('3',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [2][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][2][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('4',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [3][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][3][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('5',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [4][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][4][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('6',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[0]
                                                                            [5][
                                                                            "username"]
                                                                                .toString(),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[0][5][
                                                                        "current_best"]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),

                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                        snapshot.data[2]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontSize: 15.0.sp,
                                                                            color: Colors.yellow.withOpacity(0.5)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            snapshot.data[3],
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5))))),
                                                                    DataCell(Text(
                                                                        snapshot.data[1].toString(),
                                                                        style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5)))),
                                                                  ],
                                                                ),
                                                              ]));
                                                    } else if (snapshot.hasError) {
                                                      print("alert");
                                                      print(snapshot.error);
                                                      return CircularProgressIndicator();
                                                    } else {
                                                      return Theme(
                                                          data: Theme.of(context).copyWith(
                                                              dividerColor: Color.fromRGBO(
                                                                  0, 0, 0, 0)),
                                                          child: DataTable(
                                                              columnSpacing: 16,
                                                              dataRowHeight: 20,
                                                              columns: <DataColumn>[
                                                                DataColumn(
                                                                  label: Text(
                                                                    '#',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'NAME',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    'SCORE',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w700,
                                                                        fontSize: 15.0.sp,
                                                                        color:
                                                                        Color.fromRGBO(
                                                                            190,
                                                                            190,
                                                                            190,
                                                                            1)),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: <DataRow>[
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                      '1',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                          fontSize: 15.0.sp,
                                                                          color: Color.fromRGBO(100, 152, 176, 1)),
                                                                    )),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('2',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            height: 1.2,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                height: 1.2,
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            height: 1.2,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('3',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('4',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('5',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),
                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text('6',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                15.0.sp,
                                                                                color: Color.fromRGBO(100, 152, 176, 1))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            15.0.sp,
                                                                            color: Color.fromRGBO(100, 152, 176, 1)))),
                                                                  ],
                                                                ),

                                                                DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w900,
                                                                            fontSize: 15.0.sp,
                                                                            color: Colors.yellow.withOpacity(0.5)))),
                                                                    DataCell(SizedBox(
                                                                        width: 130,
                                                                        child: Text(
                                                                            "_",
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5))))),
                                                                    DataCell(Text(
                                                                        "_",
                                                                        style: TextStyle(fontSize: 15.0.sp, color: Colors.yellow.withOpacity(0.5)))),
                                                                  ],
                                                                ),
                                                              ]));
                                                    }
                                                  }),
                                              SizedBox(height: 20),

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
                                  filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.yellow,
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
                                          child: Text('Press to Play',
                                              style: TextStyle(
                                                  fontSize: 25.0.sp,
                                                  fontFamily: "sansSar",
                                                  color: Colors.lightBlueAccent)),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 50.0),
                                          child: ButtonTheme(
                                            minWidth: double.infinity,
                                            height: 40.0,
                                            child: MaterialButton(

                                              shape: RoundedRectangleBorder(
                                                /*side: BorderSide(
                              color: Colors.grey,
                              width: 3),*/
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              color: Color.fromRGBO(100, 152, 176, 1),
                                              onPressed: () => setState(() {

                                                Navigator.push(
                                                  context,
                                                  ScaleRoute(page: Game(tempt: true)),
                                                );
                                                pauseGame = false;
                                              }),
                                              child: BlinkText(
                                                '- PLAY -',
                                                style: TextStyle(
                                                  fontSize: 20.0.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                                endColor: Color.fromRGBO(200, 200, 200, 1),
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
