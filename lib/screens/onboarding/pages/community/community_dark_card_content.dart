import 'package:flutter/material.dart';

import '../../../../constants.dart';


class CommunityDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
            margin: const EdgeInsets.all(10.0),
            // padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(

            ),child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(image: AssetImage('assets/images/sample1.png'),

             ),
          ),
        );


  }
}