import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:flutter_icons/ionicons.dart';

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

  @override
  Widget build(BuildContext context) {
    if (!playGame) {
      contexts = context;
      var screenHeight = MediaQuery.of(context).size.height;
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      return MaterialApp(
          home:
              //Scaffold(
              // drawer: AppDrawer(),
              // body:
              Scaffold(
                  body: Column(children: <Widget>[
        SizedBox(height: 20),
        Padding(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

        Container(
          child: const Text('HIGH SCORES:',
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        RaisedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(Entypo.getIconData("log-out")),
          ),

          color: Colors.blue,
          onPressed: () => setState(() {
            signOut.call();
          }),
        )])),
        SizedBox(height: 10),
        DataTable(columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Rank',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Username',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),

          DataColumn(
            label: Text(
              'Score',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ], rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('1')),
              DataCell(Text('snowball')),
              DataCell(Text('25052')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('aurko')),
              DataCell(Text('7527')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('Becka')),
              DataCell(Text('05025')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('X')),
              DataCell(Text('You')),
              DataCell(Text('05025')),
            ],
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: new Text("Refresh",
              style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0)),
          color: Colors.orange,
          onPressed: () => setState(() {

          }),
        ),
        SizedBox(
          height: 40,
        ),
        RaisedButton(
          child: new Text("Insert Token",
              style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0)),
          color: Colors.red,
          onPressed: () => setState(() {
            playGame = true;
          }),
        ),

      ])));
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onboarding Concept',
        home: Builder(
          builder: (BuildContext context) {
            var screenHeight = MediaQuery.of(context).size.height;
            return Container(child: Game());
          },
        ),
      );
    }
  }
}
