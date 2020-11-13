import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../home.dart';
import '../../../routes.dart';
import '../../../topScores.dart';
import '../login.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';



class LoginForm extends StatelessWidget {
  final Animation<double> animation;
  final usernameUser = TextEditingController();
  final passwordUser = TextEditingController();

   LoginForm({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: true,
            controller: usernameUser,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',

              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: space),
          TextField(
            obscureText: true,
            controller: passwordUser,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: CustomButton(
              color: Colors.red,
              textColor: Colors.white,
              text: 'Login to continue',
              onPressed: () {
                //authenticate(Text(usernameUser.text),Text(passwordUser.text));
                runApp(MyApp());
              },
            ),
          ),

          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 4 * space,
            child: CustomButton(
              color: kBlack,
              textColor: kWhite,
              text: 'Create a PRIMEDASH Account',
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(context),
      theme: ThemeData(),
      home: TopScores(),
    );
  }
}
