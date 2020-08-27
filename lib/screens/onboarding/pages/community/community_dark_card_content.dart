import 'package:flutter/material.dart';

import '../../../../constants.dart';


class CommunityDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: Container ( child: ClipRect(
            //borderRadius: BorderRadius.circular(8.0),
            child: Image(image: AssetImage('assets/images/sample1.png'),height: 600),
          ),)
        ),
      ],
    );
  }
}
