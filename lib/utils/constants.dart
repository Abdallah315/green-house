import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color myYellow = const Color(0xffcaa601);
Color myGreen = const Color(0xff3C4F22);
Color myDarkYellow = const Color.fromRGBO(202, 166, 1, 0.4);
