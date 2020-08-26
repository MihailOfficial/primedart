import 'package:bird/widgets/logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import '../../../constants.dart';
import 'fade_slide_transition.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const SizedBox(height: kSpaceM),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'PrimeDash',
              style: TextStyle(fontFamily: 'logo', fontSize: 30, color: Color.fromRGBO(252,238,10, 1)),
            ),
          ),
          const SizedBox(height: kSpaceS),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 16.0,
            child: Text(
              'Show off your prime knowledge.',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Color.fromRGBO(255,255,255, 0.8)),
            ),
          ),
        ],
      ),
    );
  }
}
