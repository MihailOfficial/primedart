import 'package:bird/product.dart';
import 'package:bird/topScores.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'routes.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader (
                accountEmail: Text("mihaildev@gmail.com"),
                accountName: Text("Mihail Ghandi"),

                ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text("Game"),
              onTap: () =>  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => Home())
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text("High Scores"),
              onTap: () =>  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new Product())
              ),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text("About"),
              onTap: () =>  Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new TopScores())
              ),
            )


          ],
        )
      );
  }
}
