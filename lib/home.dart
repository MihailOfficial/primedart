import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String routeName = "/home";
  bool playGame = false;
  @override
  Widget build(BuildContext context) {
    if (!playGame){
      contexts = context;
      var screenHeight = MediaQuery.of(context).size.height;
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      return MaterialApp(home:
      //Scaffold(
      // drawer: AppDrawer(),
      // body:
      Scaffold(
          body: Column(
              children: <Widget>[
                DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Age',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Role',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sarah')),
                          DataCell(Text('19')),
                          DataCell(Text('Student')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Janine')),
                          DataCell(Text('43')),
                          DataCell(Text('Professor')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('William')),
                          DataCell(Text('27')),
                          DataCell(Text('Associate Professor')),
                        ],
                      ),]),
                SizedBox(height: 20,),
                RaisedButton(
                    child: new Text("New Game", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                    color: Colors.red,
                    onPressed: () => setState(() {
                      playGame = true;
                    }),
                )])));

    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Onboarding Concept',
        home: Builder(
          builder: (BuildContext context) {
            var screenHeight = MediaQuery.of(context).size.height;
            return
              Container (
                  child: Game());
          },
        ),
      );
    }
  }
}