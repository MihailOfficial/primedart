import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';



class CardsStack extends StatelessWidget {
  final int pageNumber;
  final Widget darkCardChild;
  final Animation<Offset> darkCardOffsetAnimation;

  const CardsStack({
    @required this.pageNumber,
    @required this.darkCardChild,
    @required this.darkCardOffsetAnimation,
  })  : assert(pageNumber != null),

        assert(darkCardChild != null),
        assert(darkCardOffsetAnimation != null);

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    var darkCardWidth = MediaQuery.of(context).size.width - 2 * kPaddingL;
    var darkCardHeight = MediaQuery.of(context).size.height / 3;

    return Padding(
      padding: EdgeInsets.only(
        top: isOddPageNumber ? 25.0 : 50.0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: <Widget>[
          SlideTransition(
            position: darkCardOffsetAnimation,


                child: darkCardChild,

              ),



        ],
      ),
    );
  }
}


//Color.fromRGBO(28, 28, 28, 1)
//Color.fromRGBO(252,238,10, 1)