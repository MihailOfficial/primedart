import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../home.dart';
import '../../../routes.dart';
import '../../../topScores.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';
import 'package:oauth2/oauth2.dart';
import 'dart:io';

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
                authenticate(usernameUser.text,passwordUser.text);
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

  void authenticate(usr, pwd) async {
    // This URL is an endpoint that's provided by the authorization server. It's
    // usually included in the server's documentation of its OAuth2 API.
    final authorizationEndpoint = Uri.parse("http://example.com/oauth2/authorization");

    // The user should supply their own username and password.
    final username = usr;
    final password = pwd;
    print(usr);
    print(pwd);

    // The authorization server may issue each client a separate client
    // identifier and secret, which allows the server to tell which client
    // is accessing it. Some servers may also have an anonymous
    // identifier/secret pair that any client may use.
    //
    // Some servers don't require the client to authenticate itself, in which case
    // these should be omitted.
    //final identifier = "my client identifier";
    //final secret = "my client secret";

    // Make a request to the authorization endpoint that will produce the fully
    // authenticated Client.
    var client = await resourceOwnerPasswordGrant(authorizationEndpoint, username, password);
    // Once you have the client, you can use it just like any other HTTP client.
    //var result = await client.read("http://example.com/protected-resources.txt");

    // Once we're done with the client, save the credentials file. This will allow
    // us to re-use the credentials and avoid storing the username and password
    // directly.
    //new File("~/.myapp/credentials.json").writeAsString(client.credentials.toJson());
    //recreate client:
    //var client2 = Client(Credentials.fromJson(File.fromUri(Uri.parse("~/.myapp/credentials.json")).readAsStringSync()));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(context),
      initialRoute: Home.routeName,
      theme: ThemeData(),
      home: TopScores(),
    );
  }
}
