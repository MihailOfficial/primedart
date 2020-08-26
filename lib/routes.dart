import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'product.dart';
import 'topScores.dart';

class Routes{
  static const String home = Home.routeName;
  static const String product = Product.routeName;
  static const String topScores = TopScores.routeName;
    static getRoutes(BuildContext context){
      return {
        product:  (context) => Product(),
        home:  (context) => Home(),
        topScores:  (context) => TopScores(),};
    }


}