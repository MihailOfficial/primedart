import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        Container(
          child: const Text('Global High Scores:'),
        ),
        SizedBox(height: 20),
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
              'Date',
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
              DataCell(Text('Feb 20, 2021')),
              DataCell(Text('25052')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('aurko')),
              DataCell(Text('Feb 20, 2021')),
              DataCell(Text('7527')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('Becka')),
              DataCell(Text('Feb 20, 2021')),
              DataCell(Text('05025')),
            ],
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: new Text("New Game",
              style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0)),
          color: Colors.red,
          onPressed: () => setState(() {
            playGame = true;
          }),
        ),
        RaisedButton(
          child: new Text("Logout",
              style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0)),
          color: Colors.blue,
          onPressed: () => setState(() {
            signOut.call();
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
